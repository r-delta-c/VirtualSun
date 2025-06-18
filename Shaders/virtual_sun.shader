Shader "DeltaField/shaders/VirtualSun"{
    Properties{
        [Header(Rendering)]
        [Space(16)]
        [Enum(UnityEngine.Rendering.CullMode)]
        _Cull("Culling Mode",Float)=0.0
        [KeywordEnum(Off,On)]
        _ZWrite("Z Write",Float)=0.0
        [Space(16)]
        [MaterialToggle]_Forced_Z_Scale_Zero("Forced Z Scale Zero",Float)=1.0
        [Toggle(_DISABLE_CUSTOM_BILLBOARD)]
        _DisableCustomBillBoard("Particle Billboard Mode(Feature)",Float)=0.0
        [KeywordEnum(None,Position,Rotation,Position_Rotation)]
        _StereoMergeMode("Stereo Merge Mode(Feature)",Int)=2
        [Toggle(_PREVIEW_MODE)]
        _PreviewMode("Preview Mode(Feature)",Float)=0.0
        [Space(16)]
        [Header(Star)]
        [Space(16)]
        _StarSize("Star Size",Range(0.0,1.0))=0.5
        _Alpha("Alpha",Range(0.0,1.0))=1.0
        [Space(16)]
        _HueEffect("Star Hue Effect",Range(0.0,1.0))=0.0
        _HueOffset("Star Hue",Range(0.0,1.0))=0.0
        [Space(16)]
        _AdditiveEmission("Additive Emission",Range(0.0,10.0))=0.0
        [Space(16)]
        [Header(Bloom)]
        [Space(16)]
        _BloomColor("Bloom Color",Color)=(1.0,0.5,0.2,1.0)
        _BloomVolume("Bloom Volume",Range(0.0,1.5))=1.0
        _BloomEaseInPower("Bloom In Curve",Float)=4.0
        _BloomEaseOutPower("Bloom Out Curve",Float)=4.0
        [Space(16)]
        [Header(Noise)]
        [Space(16)]
        [Toggle(_USING_TEXTURE)]
        _UsingTexture("Using Texture(Feature)",Float)=0.0
        _Texture("Texture", 2D)=""{}
        [Space(16)]
        _Scale("Noise Scale",Vector)=(1.0,1.75,0.0,0.5)
        _NoisePhaseScale("Noise Phase Scale",Float)=8.0
        _NoisePhaseTime("Noise Phase Time",Float)=6.0
        _NoiseXScroll("Noise X Scroll",Float)=0.0
        _NoiseYScroll("Noise Y Scroll",Float)=0.0
        _NoiseXScrollTime("Noise X Scroll Time",Float)=4.0
        _NoiseYScrollTime("Noise Y Scroll Time",Float)=0.0
        _SphericalDistortion("Spherical Distortion",Float)=20.0
    }
    SubShader{
        Tags { "RenderType"="Transparent" "Queue"="Transparent" "LightMode"="ForwardBase"}
        Blend SrcAlpha OneMinusSrcAlpha
        Cull [_Cull]
        ZWrite [_ZWrite]

        Pass{
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            #pragma shader_feature_local _STEREOMERGEMODE_NONE _STEREOMERGEMODE_POSITION _STEREOMERGEMODE_ROTATION _STEREOMERGEMODE_POSITION_ROTATION

            #pragma shader_feature_local _FLIPTEXCOORD_NONE _FLIPTEXCOORD_FLIP_X _FLIPTEXCOORD_FLIP_Y _FLIPTEXCOORD_FLIP_XY
            #pragma shader_feature_local _ _PREVIEW_MODE
            #pragma shader_feature_local _ _DISABLE_CUSTOM_BILLBOARD
            #pragma shader_feature_local _ _USING_TEXTURE

            struct appdata{
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                fixed4 color : COLOR;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f{
                float4 vertex : SV_POSITION;
                float2 texcoord : TEXCOORD0;
                float2 uv : TEXCOORD1;
                fixed alpha : TEXCOORD2;

                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            float _Forced_Z_Scale_Zero;

            float _StarSize;
            float _Alpha;
            sampler2D _Texture;
            float4 _Texture_ST;
            float _HueEffect;
            float _HueOffset;

            float _AdditiveEmission;

            fixed4 _BloomColor;
            float _BloomVolume;
            float _BloomEaseInPower;
            float _BloomEaseOutPower;
            
            float4 _Scale;
            float _X;
            float _Y;
            float _NoisePhaseScale;
            float _NoisePhaseTime;
            float _NoiseXScroll;
            float _NoiseYScroll;
            float _NoiseXScrollTime;
            float _NoiseYScrollTime;

            float _SphericalDistortion;

            #include "Packages/com.deltafield.shader_commons/Includes/macro_stereo_merge.hlsl"
            
            #include "Packages/com.deltafield.shader_commons/Includes/functions_math.hlsl"
            #include "Packages/com.deltafield.shader_commons/Includes/functions_random.hlsl"
            #include "Packages/com.deltafield.shader_commons/Includes/functions_stereo_merge.hlsl"

            #ifdef _FLIPTEXCOORD_FLIP_X
                #define FLIP_TEX float2(-2.0,2.0)
            #elif _FLIPTEXCOORD_FLIP_Y
                #define FLIP_TEX float2(2.0,-2.0)
            #elif _FLIPTEXCOORD_FLIP_XY
                #define FLIP_TEX -2.0
            #else
                #define FLIP_TEX 2.0
            #endif

            v2f vert(appdata v){
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f,o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                #ifdef _DISABLE_CUSTOM_BILLBOARD
                    o.alpha = v.color.a;
                    #include "Packages/com.deltafield.shader_commons/Includes/vertex_non_billboard.hlsl"
                #else
                    o.alpha = 1.0;
                    #include "Packages/com.deltafield.shader_commons/Includes/vertex_billboard.hlsl"
                #endif

                o.texcoord = (v.texcoord-0.5)*FLIP_TEX;
                o.uv = TRANSFORM_TEX(o.texcoord,_Texture);

                return o;
            }

/////////////////////////////////////////////////////////////////////////////////////

            float HueCurve(float i){
                return saturate(abs(frac(i)*6.0-3.0)-1.0);
            }

            float HueMove(float3 c, float offset){
                return lerp(c.b,lerp(c.g,c.r,HueCurve(offset-_HueOffset)),HueCurve(offset-_HueOffset));
            }

            float2 cycleloop(float2 n, float scale, float adjust, float mul_scroll){
                float2 uv = float2(
                    n.x+_Time.x*_NoiseXScrollTime*mul_scroll,
                    n.y+_Time.x*_NoiseYScrollTime*mul_scroll);
                return float2(cos((uv.x+adjust)*scale),sin((uv.y+adjust)*scale));
            }

            float RandomLoop(float2 n){
                float r = 0.0;
                r += PerlinNoise(cycleloop(n,2.0,0.10,0.80));
                r += PerlinNoise(cycleloop(n,5.0,0.15,0.95));
                r += PerlinNoise(cycleloop(n,7.0,0.20,1.00));
                r += smoothstep(0.05,0.95,PerlinNoise(cycleloop(n,11.0,0.25,0.90)));
                r += smoothstep(0.60,0.85,PerlinNoise(cycleloop(n,13.0,0.30,0.85)));
                r += smoothstep(0.40,1.00,PerlinNoise(cycleloop(n,16.0,0.35,0.85)));
                return r / 6.0;
            }

            fixed4 frag (v2f i) : SV_Target{
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                float noise = 0.0;
                fixed4 c = fixed4(0.0,0.0,0.0,1.0);
                float leng = length(i.texcoord);
                #ifdef _USING_TEXTURE
                    noise = PerlinNoise((tex2D(_Texture,i.uv).r)*UNITY_PI*2.0+_Time.x*_NoisePhaseTime);
                #else
                    i.texcoord *= (1.0+leng*leng*leng*leng*leng*_SphericalDistortion);
                    float2 uv_noise = float2((i.texcoord.x+_NoiseXScroll)*_Scale.x,(i.texcoord.y+_NoiseYScroll)*_Scale.y);
                    noise = PerlinNoise(RandomLoop(uv_noise*_Scale.w)*_NoisePhaseScale+_Time.x*_NoisePhaseTime);
                #endif

                float noise_r = noise + 1.0;
                c.r = 1.0-pow(noise_r,-2.0)+0.3;

                float noise_g = noise - 0.1;
                float noise_g0 = pow(noise_g+0.5,4.0)*0.4+0.1;
                float noise_g1 = 1.0-pow(-2.0*noise_g+2.0,3.0)*0.5;
                c.g = noise_g<0.5?noise_g0:noise_g1;

                float noise_b = noise + 0.1;
                c.b = noise_b*noise_b*noise_b*noise_b*noise_b;

                c.rgb = smoothstep(0.05,0.85,c.rgb);

                c.rgb = lerp(c.rgb,float3(HueMove(c.rgb,0.0/3.0),HueMove(c.rgb,1.0/3.0),HueMove(c.rgb,2.0/3.0)),_HueEffect);

                float bloom_volume = 0.0==_BloomVolume?0.0:1.0/_BloomVolume;
                float bloom_pos = _StarSize*2.0;

                float inout_v = min(1.0,max(-1.0,(leng*2.0-bloom_pos)*bloom_volume));
                float in_r  = saturate( pow(1.0 - abs(inout_v),_BloomEaseInPower) * 3.0-1.9);
                float out_r = saturate( pow(1.0 - abs(inout_v),_BloomEaseOutPower) * 1.0+0.0);
                float4 bloom = saturate(
                    leng+1.0-bloom_pos*0.5 < 1.0 ? in_r:out_r
                )*abs(sign(bloom_volume));

                bloom *= _BloomColor;

                c = saturate(c*sign(max(0.0,_StarSize-leng))+lerp(1.0,c,frac(2.0-saturate(leng*2.0))*_StarSize)*bloom);

                c.rgb *=(_AdditiveEmission+1.0);

                #ifdef _PREVIEW_MODE
                    c.rgb *= i.alpha;
                    c.a = 1.0;
                #else
                    c.a *= i.alpha;
                #endif

                return c;
            }
            ENDHLSL
        }
    }
}

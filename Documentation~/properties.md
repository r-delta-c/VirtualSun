# Properties | プロパティ
VirtualSunのプロパティ解説です。<br>
(独自のプロパティ以外の解説は省略します。)


## Rendering
|Property|Description|
|:--|:--|
|Culling Mode|カリングの方法を指定するプロパティです。<br>`None` \| ポリゴンの両面を描写します。<br>`Back` \| ポリゴンの裏面を描写しません。<br>`Front` \| ポリゴンの表面を描写しません。|
|Z Write|デプスバッファの書き込みを許可するかを指定します。|
|Forced Z Scale Zero|モデルのZ方向のスケールを0にします。|
|Particle Billboard Mode(Feature)|当シェーダーをパーティクルで使用する場合はこのプロパティにチェックを入れてください。<br>有効時、Particle Systemのカラー設定のアルファ値が、歪みの効果量の影響を受けるようになります。<br>これによりParticle Systemの設定に応じて柔軟な制御が可能です。|
|Stereo Merge Mode(Feature) | ステレオレンダリング時に左右のカメラの位置の中間を取って描写することができます。<br>`None` \| 何も平均化しません。<br>`Position` \| 座標を中間にします。左右で同じ位置に描写されるため、奥行きが分からなくなるような錯覚を受けます。<br>GrabPassを使用し、極端に景色を歪ませるような用途に対して利用すると、スレテオレンダリング時の描写の左右差を抑えることができる可能性があります。<br>`Rotation` \| 向きを中間にします。**Pimax**といった、左右のカメラで異なる向きを持つ特殊な描写環境に対して調整する目的で使用されます。<br>`Position_Rotation` \| 座標と向きを中間にします。|
|Preview Mode(Feature)|主にデバッグ利用を想定した描写モードです。黒い背景が追加されます。|


## Star
|Property|Description|
|:--|:--|
|Star Size|星のサイズを指定します。Texcoord(UV)で描写を決定しており、サイズに制限がある関係で、基本的にモデル側でスケールを指定することおすすめします。|
|Alpha|星の描写の透明度を指定します。Particle Billboard Mode(Feature)のチェックが外れている時のみ影響があります。|
|Star Hue Effect<br>Star Hue|星の色を色相でずらすことができます。<br>`Star Hue Effect`では色相をずらした結果の影響力を指定できます。<br>`Star Hue`では色相をずらすことができます。|
|Additive Emission|エミッションを模した加算が可能です。<br>最終的なRGB値に対して乗算されます。|


## Bloom
|Property|Description|
|:--|:--|
|Bloom Color|ブルームの色を指定できます。|
|Bloom Volume|ブルームのサイズを指定できます。ブルームのサイズは`Star Size`を考慮しません。よって、双方のサイズが一定を超えると実際のメッシュをはみ出してしまい、ブルームが途切れてしまいます。<br>適切なサイズを推奨します。`Star Size`の大きさは0.5までにしておくと、`Bloom Volume`の最大値1.5でもはみ出なくなります。|
|Bloom In Curve<br>Bloom Out Curve|それぞれ、ブルームの内側(In)、外側(Out)の減衰のカーブ強度を指定します。<br>値が高いほど急激に減衰するようになります。|


## Noise
|Property|Description|
|:--|:--|
|Using Texture|シェーダーのみで生成されるノイズではなく、テクスチャを基にノイズを生成します。<br>有効にすると処理が軽量になりますが、下記のプロパティが無効になります。<br>`Noise Phase Scale`<br>`Noise X,Y Scroll`<br>`Noise X,Y Time`<br>`Spherical Distortion`|
|Texture|ノイズで使用するテクスチャ関連の制御ができます。|
|Noise Phase Scale|ノイズの変化周期のスケールを指定します。|
|Noise Phase Time|ノイズの変化速度を指定します。|
|Noise X Scroll<br>Noise Y Scroll|ノイズの各方向のオフセットを指定します。|
|-Noise X Scroll Time<br>-Noise Y Scroll Time|ノイズの各方向のスクロール速度を指定します。|
|Spherical Distortion|球体の縁側に近づくほど描写が圧縮される、つまり疑似球体表現の効果を指定するプロパティです。|
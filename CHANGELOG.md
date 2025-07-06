# Change Log

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0-exp.1] 2025/07/06
### Changed
- DeltaField-Shader-Commonsの仕様変更により、同シェーダーも以下のような変更をしました。
- ビルボード描写を切り替える**Particle Billboard Mode(Feature)**`PropertyName: _DisableCustomBillboard`の名称を変更。<br>トグルの反転を想定挙動として取り扱います。
    - PropertyName: `_DisableCustomBillboard` → `_BillboardMode`
    - KeywordName: `_DISABLE_CUSTOM_BILLBOARD` → `_BILLBOARD_MODE`
    - `True` | ビルボード描写が有効になります。
    - `False` | ビルボード描写にはならず通常の描写になります。
- 環境要件にて要求されるパッケージ、`DeltaField-Shader-Commons`は`v1.0.0`が必要になります。それ以前のバージョンは使用できません。

## [0.0.1-exp.1] 2025/06/21
- 正常にインポートができない環境への対処として、パッチバージョン上昇のみのアップデートを行いました。


## [0.0.0-exp.1] 2025/06/18
### Changed
- ステレオレンダリング用の補正処理をDeltaField-Shader-CommonsにIncludeとして移行。
- ノイズの計算処理を変更。
- `shader_feature`を`shader_feature_local`に変更。
- プロパティ配置を変更。

### Fixed
- Single Pass Instanced環境下で正常に動作しない不具合を修正。
- 一部のキーワードが適切に動作しない不具合を修正。
- `_SphericalDistortion`が有効値の際に、時間経過で湾曲が次第に強くなる問題を修正。



## [OldLog]
```
prototype-1.0 限定公開 2025/04/01
シェーダー側で透明度を制御するプロパティ、Alphaを追加。
Particle Billboard Mode(Feature)を有効にした状態で、Particle Systemのアルファ値を参照する仕様に変更。
shader_featureの状態分岐が不足していた不具合を修正。


dev-1.0 限定公開 2025/02/26
```

[1.0.0-exp.1]: https://github.com/r-delta-c/VirtualSun/compare/0.0.0-exp.1...1.0.0
[0.0.1-exp.1]: https://github.com/r-delta-c/VirtualSun/compare/0.0.0-exp.1...0.0.1-exp.1

<!--
## [Unreleased]

[Unreleased]: https://github.com/r-delta-c/VirtualSun/compare/0.0.0-exp.1...1.0.0

-->
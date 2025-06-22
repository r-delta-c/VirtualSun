# Change Log

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

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

[0.0.1-exp.1]: https://github.com/r-delta-c/VirtualSun/compare/0.0.0-exp.1...0.0.1-exp.1

<!--
## [Unreleased]

[Unreleased]: https://github.com/r-delta-c/VirtualSun/compare/0.0.0-exp.1...1.0.0

-->
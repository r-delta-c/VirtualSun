# VirtualSun
Copyright (c) 2025, DeltaField



## Overview | 概要
Name: VirtualSun<br>
Version: 0.0.1-exp.1<br>

シェーダー処理のみで太陽のような球体の星を表現するシェーダーです。
<br>

以下の機能を特徴としています。
* 簡易的なノイズシェーダーを基にマグマのような揺らぎうごめく表現が可能。
* テクスチャをノイズ代わりにすることも可能で、非常に軽量な処理になります。
* ノイズの調整の他、星の色、疑似的なブルーム(グロー)表現、エミッション加算の機能。

## Requirements | 環境要件
現在、以下の環境で動作を確認しています。
* Unity 2022.3
* Built-in Render Pipeline
* Unity XR Single-pass Instanced

以下の前提パッケージが必要です。VPMでインストールした場合は自動的にインポートされます。
* [DeltaField-Shader-Commons](https://github.com/r-delta-c/DeltaField-Shader-Commons)



## Caution | 警告
* 動作保証外として、実際に検証ができなかった環境があります。<br>***Pimaxといったステレオ描写が特殊な機器等***<br><br>正常な動作を確認できていないため、保証はできかねます。ご了承ください。



## Installation instructions | インストール方法
### VPM - ***推奨***
[Package Listing WEB](https://r-delta-c.github.io/vpm_repository/)へ移動し、**Add to VCC**というボタンを押して、VRChat Creator Companionを開きます。<br>
リポジトリを加えましたら、導入したいプロジェクトのManage Packagesを開き、一覧に加わっているMeshHologramをインストールしてください。

### Package Manager - ***推奨***
Unityのタブメニューから、**Window -> Package Manager**を押してPackage Managerを開きます。<br>
Package Managerの左上にある**+**ボタンを押して、**Add package from git URL...**を押します。<br>
開かれた入力ダイアログに以下のリンクを張り付けて、**Add**を押して加えてください。<br>
```
https://github.com/r-delta-c/VirtualSun.git
```
**[Requirements | 環境要件]に前提パッケージが記載されていた場合は、先にそちらをインポートしてください。**

### .unitypackage
[リリースデータ](https://github.com/r-delta-c/VirtualSun/releases)から任意のバージョンを探して、Assets内の末尾が **.unitypackage**になっているデータをDLしてください。<br>
DLした.unitypackageは、起動したUnity上へ**ドラッグ&ドロップ**することでインポートできます。



## How to Use | 使い方
以下のページを参照してください。<br>
[Properties | プロパティ](https://github.com/r-delta-c/VirtualSun/blob/main/Documentation~/properties.md "Documentation~/properties.md")



## License | ライセンス
このシェーダーはMIT Licenseによって提供されます。
LICENSE.mdの内容に則ってご利用ください。

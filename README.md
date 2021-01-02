# Fix-video-flicker
This batch removes videos flicker

AviUtlの導入と60fpsフリッカ軽減プラグインの導入と
フォルダ内の*.movの一括処理を行います。


## HowToUse
1. execute setup.bat --> 同じフォルダにdistを作成、必要なモジュールがダウンロードされます
2. dist/main.batに処理したい対象のフォルダをドラッグアンドドロップします
3. resultsに処理した動画が格納されます

## Requirements
* windows10
* NVIDIA GPU

## Dependency(setup.batでdownload)
* 7-zip
* aviutl110
* flicker60_0.2.2
* L-SMASH_Works_r940_plugins
* NVEncC_5.24_x64
* auc_15


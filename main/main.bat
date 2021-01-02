@echo off
@setlocal enabledelayedexpansion
set current_dir=%~dp0
set tmp_dir=%current_dir%tmp\
set OUTPUT_PATH=%current_dir%results\

rem Aviutlの場所とAUCの場所を指定する。デフォルトはバッチファイルと同じ場所。
set AVIUTL="%current_dir%aviutl\aviutl.exe"
set AUC_DIR="%current_dir%auc\"


REM 出力プラグインの番号を指定してください
set OUTPUT_PLUGIN=0
set OUTPUT_PROFILE=0

set path=%1
echo path : !path!

echo Aviutlを起動しています。
"%AUC_DIR%auc_exec" "%AVIUTL%" > nul
set WINDOW_ID=!ERRORLEVEL!
echo Aviutl WINDOW_ID:!WINDOW_ID!

FOR %%J IN (%path%\*.mov) DO (
  set INPUT_FILE=%%J
  set OUTPUT_FILE=!OUTPUT_PATH!%%~nJ.mp4
  if not exist "!OUTPUT_FILE!" (
    echo ==================================
    echo アンチフリッカー処理開始 filename : !INPUT_FILE!
    echo ==================================

    echo ファイルを開いています。
    call "%AUC_DIR%auc_open" "!WINDOW_ID!" "!INPUT_FILE!"

    echo プロファイルを0に変更
    rem メニューで一番上のプロファイルの番号が0で、以下1、2...
    call "%AUC_DIR%auc_setprof" "!WINDOW_ID!" "!OUTPUT_PROFILE!"

    echo プラグイン:%OUTPUT_PLUGIN%で出力します。OUTPUT_FILE:!OUTPUT_FILE!
    rem メニューで一番上の出力プラグインの番号が0で、以下1、2...
    call "%AUC_DIR%auc_plugout" "!WINDOW_ID!" "%OUTPUT_PLUGIN%"  "!OUTPUT_FILE!"

    echo 出力を待っています。
    call "%AUC_DIR%\auc_wait" "!WINDOW_ID!"

    echo finished encoding OUTPUT_FILE:!OUTPUT_FILE!
    call "%AUC_DIR%\auc_close" "!WINDOW_ID!"

  )
)
call "%AUC_DIR%\auc_exit" "!WINDOW_ID!"
echo 全ファイルのエンコードを終了しました

exit /b

rem フォルダ作成 
:mdir
IF NOT EXIST "%1" (mkdir "%1")
exit /b

:getini
rem 設定ファイルパス
echo getini
set CONFFILE=%1
rem 設定ファイルが存在するか確認する
if not exist %CONFFILE% (
    echo ERROR: Not found "%CONFFILE%"
    exit /b 1
)
rem 設定ファイルを読み込む
for /f "usebackq tokens=1,* delims==" %%a in (%CONFFILE%) do (
    rem 環境変数として登録する
    echo %%a=%%b
    set %%a=%%b
)

exit /b

:saveini
  > "%catalog_dir%split!splitid!.ini" echo splitid=!splitid!
  >> "%catalog_dir%split!splitid!.ini" echo st=!st!
  >> "%catalog_dir%split!splitid!.ini" echo en=!en!
  >> "%catalog_dir%split!splitid!.ini" echo timestamps=!timestamps!
  >> "%catalog_dir%split!splitid!.ini" echo frameCount=!frameCount!
exit /b

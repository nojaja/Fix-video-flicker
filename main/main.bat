@echo off
@setlocal enabledelayedexpansion
set current_dir=%~dp0
set tmp_dir=%current_dir%tmp\
set OUTPUT_PATH=%current_dir%results\

rem Aviutl�̏ꏊ��AUC�̏ꏊ���w�肷��B�f�t�H���g�̓o�b�`�t�@�C���Ɠ����ꏊ�B
set AVIUTL="%current_dir%aviutl\aviutl.exe"
set AUC_DIR="%current_dir%auc\"


REM �o�̓v���O�C���̔ԍ����w�肵�Ă�������
set OUTPUT_PLUGIN=0
set OUTPUT_PROFILE=0

set path=%1
echo path : !path!

echo Aviutl���N�����Ă��܂��B
"%AUC_DIR%auc_exec" "%AVIUTL%" > nul
set WINDOW_ID=!ERRORLEVEL!
echo Aviutl WINDOW_ID:!WINDOW_ID!

FOR %%J IN (%path%\*.mov) DO (
  set INPUT_FILE=%%J
  set OUTPUT_FILE=!OUTPUT_PATH!%%~nJ.mp4
  if not exist "!OUTPUT_FILE!" (
    echo ==================================
    echo �A���`�t���b�J�[�����J�n filename : !INPUT_FILE!
    echo ==================================

    echo �t�@�C�����J���Ă��܂��B
    call "%AUC_DIR%auc_open" "!WINDOW_ID!" "!INPUT_FILE!"

    echo �v���t�@�C����0�ɕύX
    rem ���j���[�ň�ԏ�̃v���t�@�C���̔ԍ���0�ŁA�ȉ�1�A2...
    call "%AUC_DIR%auc_setprof" "!WINDOW_ID!" "!OUTPUT_PROFILE!"

    echo �v���O�C��:%OUTPUT_PLUGIN%�ŏo�͂��܂��BOUTPUT_FILE:!OUTPUT_FILE!
    rem ���j���[�ň�ԏ�̏o�̓v���O�C���̔ԍ���0�ŁA�ȉ�1�A2...
    call "%AUC_DIR%auc_plugout" "!WINDOW_ID!" "%OUTPUT_PLUGIN%"  "!OUTPUT_FILE!"

    echo �o�͂�҂��Ă��܂��B
    call "%AUC_DIR%\auc_wait" "!WINDOW_ID!"

    echo finished encoding OUTPUT_FILE:!OUTPUT_FILE!
    call "%AUC_DIR%\auc_close" "!WINDOW_ID!"

  )
)
call "%AUC_DIR%\auc_exit" "!WINDOW_ID!"
echo �S�t�@�C���̃G���R�[�h���I�����܂���

exit /b

rem �t�H���_�쐬 
:mdir
IF NOT EXIST "%1" (mkdir "%1")
exit /b

:getini
rem �ݒ�t�@�C���p�X
echo getini
set CONFFILE=%1
rem �ݒ�t�@�C�������݂��邩�m�F����
if not exist %CONFFILE% (
    echo ERROR: Not found "%CONFFILE%"
    exit /b 1
)
rem �ݒ�t�@�C����ǂݍ���
for /f "usebackq tokens=1,* delims==" %%a in (%CONFFILE%) do (
    rem ���ϐ��Ƃ��ēo�^����
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

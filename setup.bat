
set current_dir=%~dp0
PATH=%current_dir%dist\7-zip;%PATH%

xcopy main dist /e/h/c/i/q

mkdir dist
mkdir dist\tmp
mkdir dist\results
rem mkdir dist\aviutl
rem mkdir dist\aviutl\Plugins


curl -o ./dist/tmp/aviutl110.zip http://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip
tar -xf ./dist/tmp/aviutl110.zip -C ./dist/aviutl/

curl -L -o ./dist/tmp/flicker60_0.2.2.zip http://auf.jpn.xxxxxxxx.jp/flicker60_0.2.2.zip
tar -xf ./dist/tmp/flicker60_0.2.2.zip -C ./dist/aviutl/Plugins/ *.auf

curl -L -o ./dist/tmp/L-SMASH_Works_r940_plugins.zip https://pop.4-bit.jp/bin/l-smash/L-SMASH_Works_r940_plugins.zip
7z x -aoa -o./dist/aviutl/Plugins/ -i!*.au? ./dist/tmp/L-SMASH_Works_r940_plugins.zip

curl -L -o ./dist/tmp/NVEncC_5.24_x64.7z https://github.com/rigaya/NVEnc/releases/download/5.24/NVEncC_5.24_x64.7z
7z x -aoa -o./dist/aviutl/NVEncC/ ./dist/tmp/NVEncC_5.24_x64.7z

curl -L -o ./dist/tmp/auc_15.zip https://aji0.web.fc2.com/auc_15.zip
7z x -aoa -o./dist/ ./dist/tmp/auc_15.zip

pause
@echo off
xcopy haxe\* ..\lmore\haxe /S /Y /I /V /Q
xcopy js\* ..\lmore\js /S /Y /I /V /Q
xcopy flash9\* ..\lmore\flash /S /Y /I /V /Q
xcopy haxelib.xml ..\lmore\ /Y /I /V /Q
echo "Zip command needed"
pause
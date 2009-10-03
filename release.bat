@echo off
xcopy haxe\* ..\moreLib\haxe /S /Y /I /V /Q
xcopy js\* ..\moreLib\js /S /Y /I /V /Q
xcopy flash9\* ..\moreLib\flash /S /Y /I /V /Q
xcopy haxelib.xml ..\moreLib\haxelib.xml /Y /I /V /Q
echo "Zip command needed"
pause
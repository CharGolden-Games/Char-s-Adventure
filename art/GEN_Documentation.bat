@echo off
echo Generating Documentation!
cd ..
REM Builds it so it can make an xml file
lime build windows -32 -release -D 32bits -D HXCPPM32 -D IS_32BIT --haxeflag="-xml export/Documentation/xml/xml.xml" --haxeflag="--macro include('charsadventure')" --haxeflag="--macro include('shared')" --haxeflag="--macro include('save_editor')"
REM Turns it into api documentation.
haxelib run dox -i export/Documentation/xml/xml.xml -o export/pages --exclude source --include charsadventure --include shared --include save_editor
pause
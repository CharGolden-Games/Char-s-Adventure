@echo off
color 0A
pyinstaller -F --workpath ./build/ --distpath ./export/ ConvertOldDialogueFiles.py
echo DONE
pause
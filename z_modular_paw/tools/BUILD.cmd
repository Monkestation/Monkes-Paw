@echo off

copy "%~dp0..\..\tgstation.dme" "%~dp0\tgstation.dme.bak"


echo #include "z_modular_paw\pawmodules.dme" >> "%~dp0..\..\tgstation.dme"

call "%~dp0..\..\tools\build\build.bat" --wait-on-error build %*

copy /y "%~dp0\tgstation.dme.bak" "%~dp0..\..\tgstation.dme"

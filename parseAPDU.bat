@ECHO off
setlocal enabledelayedexpansion
if [%~1]==[] goto :ask_input

set bytes=
call :insert_space_each_byte %* bytes
REM echo bytes=%bytes%
echo %bytes%>abc.txt
py apdu_parser.py -T -i abc.txt
del abc.txt
REM pause
goto :EOF










:ask_input
echo input APDU cmds as parameter 
echo example: 
echo    parseAPDU.bat 00B2011400
echo    parseAPDU.bat \x00\xB2\x01\x14\x00
pause
goto :EOF


:insert_space_each_byte
set v=%1
REM echo input=%v%
set var=
set /a l=0
:loop_insert_space_each_byte
set c=!v:~%l%,2!
if "%c%"=="" goto end_insert_space_each_byte
if "%c%"=="\x" set /a l+=2 && goto loop_insert_space_each_byte
set "var=%var%%c% "
set /a l+=2
goto loop_insert_space_each_byte
:end_insert_space_each_byte
REM echo output=%var%
set %2=%var%
REM echo !%2!
goto :EOF


:insert_space
set v=%*
set var=
set /a l=0
:loop_insert_space
set c=!v:~%l%,2!
if "%c%"=="" goto end_insert_space
set "var=%var%%c% "
set /a l+=2
goto loop_insert_space
:end_insert_space
echo %var%
goto :EOF
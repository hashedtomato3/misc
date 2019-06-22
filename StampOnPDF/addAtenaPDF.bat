
@echo off

set TORIHIKISAKI=�O�H�d�@�������
set MAKER=���l�T�X�e�N�m���W �������
set INPDF=250_information.pdf
set OUTPDF=out.pdf


REM ����HTML�𐶐�����
del temp.htm
setlocal enabledelayedexpansion
for /f "delims=" %%A in (AtenaTemplate.htm) do (
    set x=%%A
�@�@if !x! equ TORIHIKISAKI set x=%TORIHIKISAKI%
�@�@if !x! equ MAKER        set x=%MAKER%
    echo !x!
) >> temp.htm

REM ����HTML��PDF�ɕϊ�����
bin\wkhtmltopdf temp.htm stamp.pdf

REM ������PDF�ɒǉ�����
pdftk %INPDF% stamp stamp.pdf output %OUTPDF%

del /F temp.htm stamp.pdf

pause

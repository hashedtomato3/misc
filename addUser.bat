
REM ���������[�U�������[�g�O���[�v�ɒǉ����遖����
@REM Usage: psexec \\COMPNAME -u USER -p PASS -h -c thisfile networkPassword

@set scr=\\192.168.1.100\share\sadakane\t\addUser.js
@set usr=usersadakane
@set pw=%1

REM �X�N���v�g�t�H���_�ɐڑ�
@for %%A in (%scr%) do @set scrDir=%%~dpA
@for %%A in (%scr%) do @set scrFile=%%~nxA
@set scrDir=%scrDir:~0,-1%
net use M: %scrDir% %pw% /user:%usr% /persistent:NO
net use

REM �X�N���v�g�����s
net localgroup Administrators
cscript M:\%scrFile% //nologo
net localgroup Administrators





net use
net use /PERSISTENT:NO
net use Y: \\192.168.1.100\share\sadakane\HOKAN\���̑�
net use
dir Y:


FOR /F "delims=^^^" %%i in ('ver') do set VVV=%%i
echo %VVV%


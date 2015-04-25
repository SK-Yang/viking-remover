rem Author: SK
rem Date: 2013/10/18
rem Version: 0.41
rem This little batch could disable and delete W32.viking.worm from your system, but it won・t process those files that has been Infected

@echo off
echo Terminating process name Logo1_.exe and Rundl132.exe
taskkill /F /IM logo1_.exe
taskkill /F /IM rundl132.exe
echo Logo1_.exe and Rundl132.exe terminated

echo Worm deleting process started
C:
cd\WINDOWS
attrib -h Logo1_.exe
attrib -h rundl132.exe
attrib -h vDll.dll
rd Logo1_.exe
rd rundl132.exe
rd vDll.dll
del Logo1_.exe
del rundl132.exe
del vDll.dll
md Logo1_.exe
md rundl132.exe
md vDll.dll
attrib +h Logo1_.exe
attrib +h rundl132.exe
attrib +h vDll.dll

echo Deleting registries for load and execute the worm when system started
reg delete ：HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Load /f
reg delete ：HKU\.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Load /f
reg delete ：HKU\S-1-5-18\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v Load /f

echo Add disallow to run policies
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun /v 1 /t REG_SZ /d Logo1_.exe
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun /v 2 /t REG_SZ /d rundl132.exe
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun /v 3 /t REG_SZ /d vDll.dll

for /f ：delims= " %%a in (．"wmic path win32_useraccount where name=・%UserName%・ get sid"．) do (
if not ：%%a"=="SID" (
set sid=%%a
goto :loop_end
)
)

:loop_end

reg add HKU\%sid%\Software\Microsoft\WindowsNT\CurrentVersion\Policies /v 1 /t REG_SZ /d Logo1_.exe
reg add HKU\%sid%\Software\Microsoft\WindowsNT\CurrentVersion\Policies /v 2 /t REG_SZ /d rundl132.exe
reg add HKU\%sid%\Software\Microsoft\WindowsNT\CurrentVersion\Policies /v 3 /t REG_SZ /d vDll.dll
echo Cleaning dummy ：_desktop.ini"
for %i in (c: d: e: f: g: h: i: j: k: l: m: n: o: p: q: r: s: t: u: v: w: x: y: z:) do del %i\_desktop.ini /f/s/q/a

echo Please reboot your system to finish the registry update
pause
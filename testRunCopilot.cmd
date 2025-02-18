@echo off
setlocal EnableDelayedExpansion

set "commandToRun=bin\Release\net9.0\win-x64\publish\CliPerf.exe"
set "iterations=10"
set "runs=100"

for /L %%i in (1,1,%iterations%) do (
    for /f "tokens=1-4 delims=:,." %%a in ("%time%") do (
        set /A "startMillis=(10%%a*3600000) + (10%%b*60000) + (10%%c*1000) + (10%%d*10)"
    )

    echo startMillis: !startMillis!
    for /L %%j in (1,1,%runs%) do (
        %commandToRun% > nul 2>&1
    )
    
    for /f "tokens=1-4 delims=:,." %%a in ("%time%") do (
        set /A "endMillis=(10%%a*3600000) + (10%%b*60000) + (10%%c*1000) + (10%%d*10)"
    )
    
    set /A "totalMillis=endMillis - startMillis"
    echo Iteration %%i: !totalMillis! ms
)

endlocal

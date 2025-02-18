@echo off
setlocal enabledelayedexpansion

:: Define the command you want to run
set "command=bin\Release\net9.0\win-x64\publish\CliPerf.exe"

IF NOT EXIST "%command%" (
    echo "Building executable"
    dotnet publish -r win-x64 -c Release
)

:: Number of times to run the command in each iteration
set "iterations=100"

:: Number of times to repeat the entire process
set "repeats=10"

:: Loop to repeat the entire process 10 times
for /L %%R in (1,1,%repeats%) do (
    :: Get the start time in hundredths of a second
    call :getTime startTotal

    :: Run the command 100 times
    for /L %%I in (1,1,%iterations%) do (
        %command%
    )

    :: Get the end time in hundredths of a second
    call :getTime endTotal

    :: Calculate the total time taken in milliseconds
    set /A "totalTime=(endTotal-startTotal)"

    :: Handle midnight rollover (if end time is less than start time)
    if !totalTime! lss 0 set /A "totalTime+=86400000"

    :: Display the total time taken
    echo Iteration %%R: !totalTime! ms
)

exit /b

:: Function to get the current time in milliseconds since midnight
:getTime
setlocal
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
    set "HH=%%a"
    set "MM=%%b"
    set "SS=%%c"
    set "CC=%%d"
)

:: Ensure time components are valid (handle single-digit hours)
if "!HH:~1!"=="" set "HH=0!HH!"
if "!MM:~1!"=="" set "MM=0!MM!"
if "!SS:~1!"=="" set "SS=0!SS!"
if "!CC:~1!"=="" set "CC=0!CC!"

:: Convert time to total milliseconds
set /A "timeTotal=(1!HH!-100)*3600000 + (1!MM!-100)*60000 + (1!SS!-100)*1000 + (1!CC!-100)*10"

:: Return the result
endlocal & set "%1=%timeTotal%"
exit /b
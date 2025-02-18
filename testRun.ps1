$commandToRun = "bin/Release/net9.0/linux-x64/publish/CliPerf"
$iterations = 10
$runs = 100

for ($i = 1; $i -le $iterations; $i++) {
    $startTime = [System.Diagnostics.Stopwatch]::StartNew()
    
    for ($j = 1; $j -le $runs; $j++) {
        Invoke-Expression $commandToRun | Out-Null
    }
    
    $startTime.Stop()
    $totalTime = $startTime.ElapsedMilliseconds
    Write-Output "Iteration ${i}: $totalTime ms"
}

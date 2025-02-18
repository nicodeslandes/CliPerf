#!/bin/bash

command_to_run="bin/Release/net9.0/linux-x64/publish/CliPerf"
iterations=10
runs=100

if [ ! -f "$command_to_run" ]; then
    echo Building executable
    dotnet publish -r linux-x64 -c Release
fi

for ((i=1; i<=iterations; i++))
do
    start_time=$(date +%s%3N)
    for ((j=1; j<=runs; j++))
    do
        $command_to_run > /dev/null 2>&1
    done
    end_time=$(date +%s%3N)
    total_time=$((end_time - start_time))
    echo "Iteration $i: $total_time ms"
done

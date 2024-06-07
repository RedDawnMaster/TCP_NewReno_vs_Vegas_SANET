#!/bin/bash

time_values=(200.0 400.0 600.0 800.0 1000.0 1200.0 1400.0 1600.0 1800.0 2000.0 2200.0 2400.0 2600.0 2800.0 3000.0)

script="sanet.tcl"

placeholder="SIMULATION_TIME"

# Iterate over each value in the array and replace the placeholder
for value in "${time_values[@]}"; do
    sed -i "s/$placeholder/$value/g" "$script"
    
    ns "$script" > /dev/null 2>&1

    ./plr.awk sanet.tr $value > /dev/null 2>&1

    # Restore the original Tcl script for the next iteration
    sed -i "s/$value/$placeholder/g" "$script"
    
    echo "SIMULATION TIME : $value Completed"
done

# TCP New Reno vs. Vegas: Comparative Analysis

## Introduction

In modern networks, the efficiency and reliability of data transmission protocols are critical to ensure seamless communication. Among the various protocols available, TCP New Reno and TCP Vegas stand out as prominent contenders, each offering distinct advantages and trade-offs. This repository provides a comparative analysis of these two TCP variants within the context of a simulated network environment.

## Objective

The primary objective of this study is to compare the performance of TCP New Reno and TCP Vegas within a simulated network environment using NS2 (Network Simulator 2) version 2.35. Specifically, the comparison focuses on packet loss rate as a metric to evaluate the efficiency of each protocol.

## Simulation Setup

The simulation environment consists of seven nodes arranged in a network topology with two sources, two destinations, and three intermediate gateways. The maximum coverage distance is set to 200 meters, reflecting typical constraints of ad hoc wireless networks.

## Experimental Design

- **Traffic Protocols**: TCP New Reno is used between certain nodes, while TCP Vegas is used for communication between others.
- **Simulation Duration**: Multiple simulations are conducted with varying durations to capture a comprehensive range of network conditions.

## Data Collection and Analysis

Using shell scripts, the simulation results are collected to generate a CSV file with three columns: simulation time, packet loss rate for TCP New Reno, and packet loss rate for TCP Vegas. This data facilitates a systematic comparison of the performance of the two protocols.

## Architecture
![Picture1](https://github.com/RedDawnMaster/TCP_NewReno_vs_Vegas_SANET/assets/100841318/d268d584-aede-4f30-b059-fad0ed37178f)

### Nodes
- **Sources (Nodes 0 and 1)**: Initiate data transmission within the network.
- **Gateways (Nodes 2, 3, and 4)**: Facilitate data transfer between source and destination nodes.
- **Destinations (Nodes 5 and 6)**: Receive data packets transmitted within the network.

Each node plays a specific role in the network, contributing to the overall communication process. By categorizing the nodes into sources, gateways, and destinations, the network architecture is structured to efficiently manage data transmission and reception.

### Traffic
- **TCP New Reno**: Used between Node 0 and Node 5.
- **TCP Vegas**: Used between Node 1 and Node 6.

## Scripts in the Repository

1. **sanet.tcl**: Contains the simulation code.
2. **plr.awk**: Calculates packet loss for both TCP New Reno and TCP Vegas after each simulation and appends the results to `output.csv`.
3. **run.sh**: Executes `sanet.tcl` iteratively with ascending simulation time values and runs `plr.awk` after each simulation.

## Plot
![Picture2](https://github.com/RedDawnMaster/TCP_NewReno_vs_Vegas_SANET/assets/100841318/e4752102-9564-4569-9850-e47504c288c3)

The plot compares the packet loss rates of TCP New Reno and TCP Vegas over the simulation time. Each curve represents a specific protocol, with simulation time on the x-axis and packet loss rate on the y-axis. As the simulation progresses, the curves show the fluctuation in packet loss rates for each protocol. Overall, TCP Vegas consistently shows a slightly lower packet loss rate compared to TCP New Reno throughout the simulation.

## Conclusion

The analysis of the data consistently demonstrates that TCP Vegas offers a notable advantage over TCP New Reno in terms of packet loss rate within the simulated network environment. Therefore, based on the results of this analysis, it is reasonable to conclude that TCP Vegas provides better performance in terms of data transmission reliability compared to TCP New Reno in this specific context.

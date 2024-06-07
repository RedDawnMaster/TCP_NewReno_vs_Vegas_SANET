# Configuration

Phy/WirelessPhy set Pt_ 0.115421     ;# Maximum coverage distance : 200 m

set val(chan)           Channel/WirelessChannel    ; #Channel Type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             7                          ;# number of mobilenodes
set val(rp)             AODV                       ;# routing protocol
set val(x)		1000
set val(y)		1000

# Initialize Global Variables

set ns_		[new Simulator]
set tracefd     [open sanet.tr w]
$ns_ trace-all $tracefd

set namtrace [open sanet.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# Set up topography object

set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

# Create God

create-god $val(nn)

# Create channel

set chan_ [new $val(chan)]

# Configure node, please note the change below.

$ns_ node-config -adhocRouting $val(rp) \
		-llType $val(ll) \
		-macType $val(mac) \
		-ifqType $val(ifq) \
		-ifqLen $val(ifqlen) \
		-antType $val(ant) \
		-propType $val(prop) \
		-phyType $val(netif) \
		-topoInstance $topo \
		-agentTrace ON \
		-routerTrace ON \
		-macTrace ON \
		-movementTrace OFF \
		-channel $chan_
	
# Creating nodes

set node_(0) [$ns_ node]
set node_(1) [$ns_ node]
set node_(2) [$ns_ node]
set node_(3) [$ns_ node]
set node_(4) [$ns_ node]
set node_(5) [$ns_ node]
set node_(6) [$ns_ node]

# Disable random motions

$node_(0) random-motion 0
$node_(1) random-motion 0
$node_(2) random-motion 0
$node_(3) random-motion 0
$node_(4) random-motion 0
$node_(5) random-motion 0
$node_(6) random-motion 0

# Nodes sizes

for {set i 0} {$i < $val(nn)} {incr i} {
	$ns_ initial_node_pos $node_($i) 40
}

# Provide initial (X,Y, for now Z=0) co-ordinates for mobilenodes

$node_(0) set X_ 1.0
$node_(0) set Y_ 203.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 1.0
$node_(1) set Y_ 1.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 125.0
$node_(2) set Y_ 102.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 250.0
$node_(3) set Y_ 102.0
$node_(3) set Z_ 0.0

$node_(4) set X_ 375.0
$node_(4) set Y_ 102.0
$node_(4) set Z_ 0.0

$node_(5) set X_ 499.0
$node_(5) set Y_ 203.0
$node_(5) set Z_ 0.0

$node_(6) set X_ 499.0
$node_(6) set Y_ 1.0
$node_(6) set Z_ 0.0

# Distance between Devices        : 202 m
# Distance between Gateways       : 125 m
# Distance between Device-Gateway : 159.92811 m

# Set up static nodes

$ns_ at 3.0 "$node_(0) setdest 1.0 203.0 0.0"
$ns_ at 3.0 "$node_(1) setdest 1.0 1.0 0.0"
$ns_ at 3.0 "$node_(2) setdest 125.0 102.0 0.0"
$ns_ at 3.0 "$node_(3) setdest 250.0 102.0 0.0"
$ns_ at 3.0 "$node_(4) setdest 375.0 102.0 0.0"
$ns_ at 3.0 "$node_(5) setdest 499.0 203.0 0.0"
$ns_ at 3.0 "$node_(6) setdest 499.0 1.0 0.0"

# Setup traffic flow between nodes

set tcp0 [new Agent/TCP/Newreno]
$tcp0 set class_ 1
set sink0 [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp0
$ns_ attach-agent $node_(5) $sink0
$ns_ connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns_ at 3.0 "$ftp0 start"

set tcp1 [new Agent/TCP/Vegas]
$tcp1 set class_ 2
set sink1 [new Agent/TCPSink]
$ns_ attach-agent $node_(1) $tcp1
$ns_ attach-agent $node_(6) $sink1
$ns_ connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns_ at 3.0 "$ftp1 start" 

# Tell nodes when the simulation ends

for {set i 0} {$i < $val(nn) } {incr i} {
    $ns_ at SIMULATION_TIME "$node_($i) reset";
}
$ns_ at SIMULATION_TIME "stop"
$ns_ at SIMULATION_TIME+0.01 "puts \"NS EXITING...\" ; $ns_ halt"
proc stop {} {
    global ns_ tracefd
    $ns_ flush-trace
    close $tracefd
}

puts "Starting Simulation..."
$ns_ run
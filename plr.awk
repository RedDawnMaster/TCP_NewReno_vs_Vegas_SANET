#!/usr/bin/awk -f

BEGIN {
 sentNewReno = 0
 receivedNewReno = 0
 sentVegas = 0
 receivedVegas = 0
 }
 
 NR == 1 && ARGC == 3 {
    simulationTime = ARGV[2]
    delete ARGV[2]  # Remove the input number from the argument list
}
 
{
 #packet loss ratio NewReno
 if($1 == "s" && $3 == "_0_" && $4 == "AGT" && $7 == "tcp") {
 	sentNewReno ++
 }
 else if ($1 == "r" && $3 == "_5_" && $4 == "AGT"  && $7 == "tcp"){
 	receivedNewReno ++
 } 
 else if($1 == "s" && $3 == "_1_" && $4 == "AGT" && $7 == "tcp"){
 	sentVegas ++
 }
 else if($1 == "r" && $3 == "_6_" && $4 == "AGT" && $7 == "tcp"){
 	receivedVegas ++
 }
}
  
 END { 
 plrNewReno = (sentNewReno - receivedNewReno)/sentNewReno
 plrVegas = (sentVegas - receivedVegas)/sentVegas
 print "\n\n#### NEW RENO ####\n\n";
 print "Sent New Reno = " sentNewReno;
 print "\nReceived New Reno = " receivedNewReno;
 print "\nPacket loss ratio = " plrNewReno
 print "\n\n#### VEGAS ####\n\n";
 print "Sent Vegas = " sentVegas;
 print "\nReceived Vegas = " receivedVegas;
 print "\nPacket loss ratio = " plrVegas
 print"\n\n#### SIMULATION TIME : " simulationTime " ####"
 print "\n";
 print simulationTime "," plrNewReno "," plrVegas >> "output.csv"
}
 

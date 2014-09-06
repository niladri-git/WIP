#!/usr/bin/perl

use strict ;
use warnings ;
use DateTime ;
 
my $year;

if ($ARGV[0]) {
    $year = $ARGV[0];
} else {
    print "Enter the value for Year: ";
    $year = <STDIN>;
    chomp($year);
}

for my $yr( $year ) {
   
    for my $i( 1..12 ) {
    	my $date = DateTime->last_day_of_month( year => $yr, month => $i );
   
	while ( $date->dow != 4 ) {
      	    $date = $date->subtract( days => 1 ) ;
   	}

	my $dd = $date->day;
	my $mon = $date->month_abbr;
	my $yy = $date->year;

	print "$dd-$mon-$yy\n";

    }
}

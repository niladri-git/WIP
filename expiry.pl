#!/usr/bin/perl

use POSIX;
use DateTime ;
use Date::Parse;

my $year;

if ($ARGV[0]) {
    $year = $ARGV[0];
} else {
    print "Enter the value for Year: ";
    $year = <STDIN>;
    chomp($year);
}

my @org_exp_dates;

for my $yr( $year ) {
   
    for my $i( 1..12 ) {
    	my $date = DateTime->last_day_of_month( year => $yr, month => $i );
   
	while ( $date->dow != 4 ) {
      	    $date = $date->subtract( days => 1 ) ;
   	}

	my $day = $date->day;
	my $month_abbr = $date->month_abbr;
	my $year = $date->year;

	push (@org_exp_dates, "$day-$month_abbr-$year");
    }
}

print "\nYear: $year\n\n";
print "Original Exp Dates:\n\n";

foreach my $dt (@org_exp_dates) {
	print "$dt\n";
}

my $hld_file = "holidays/holidays.$year";
my @exp_dates;

open (FILE, "$hld_file") or die "Couldn't open file $hld_file: $!";

while (<FILE>) {

    if (/Thursday/) {
        my ($sno, $date, $day, $remarks) = split (/\s+/, $_);

        if ($date > 23) {
            push(@exp_dates, $date);
        }
    }
}

close (FILE);

print "\nShift in Expiry Date due to Holiday\n\n";
foreach my $org_exp (@exp_dates) {
    print "Org Exp Date: $org_exp\n";

    my $new_exp = str2time($org_exp) - 86400;
    print "New Exp Date: " . strftime "%d-%b-%Y \n\n", localtime $new_exp;
}


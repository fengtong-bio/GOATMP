#!/usr/bin/perl -w 
my (%A,%B,$now,@a,$av,$all);
while (<>){
chomp;
@a = split;
$a[0] =~ /^(\S+bin\.\d+)/;
$now = $1;
$A{$now} ++;
$B{$now} += $a[2];
}

foreach (keys %A){
chomp;
$now = $_;
$av = $B{$now}/$A{$now};
$all += $av;
}

foreach (keys %A){
chomp;
$now = $_;
$av = ($B{$now}/$A{$now})/$all;
print "$now\t$av\n";
}

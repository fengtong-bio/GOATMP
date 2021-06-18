#!/usr/bin/perl -w 
my (%A,$now,@a,$file,$now2,%B);
my $n = "ID";

open LIST,"$ARGV[0]" || die;
while (<LIST>){
chomp;
$now = $_;
$file = "13_Relative_abundance/$now\_relative_abundance.txt";
open IN,"$file" || die;
while (<IN>){
chomp;
$now2 = $_;
@a = split(/\t/,$now2);
$B{$a[0]} = 0;
}
}
close LIST;

open LIST,"$ARGV[0]" || die;
$sit = 0;
while (<LIST>){
chomp;
$now = $_;
$file = "13_Relative_abundance/$now\_relative_abundance.txt";
$sit++;
open IN,"$file" || die;
$n .= "\t$now";
while (<IN>){
chomp;
$now2 = $_;
@a = split(/\t/,$now2);
$A{$a[0]} .= "\t$a[1]";
$B{$a[0]}++;
}
foreach (keys %B){
$now2 = $_;
if ($B{$now2} < $sit){
$A{$now2} .= "\t0";
$B{$now2} ++;
}
}

close IN;
}

print "$n\n";

foreach (keys %A){
print "$_$A{$_}\n";
}


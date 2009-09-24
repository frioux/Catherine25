#!perl
use strict;
use warnings;
use feature ':5.10';
use FindBin;
use lib "$FindBin::Bin/../lib";

use Crypt::NQR13_f;

my $message = <<'SO ITS YOUR BIRTHDAY';

happy birthday

the coupons you have or will find spread throughout your gifts are called froupons

you can use a froupon to ask me to come to greenville from dallas with no planning for any reason at all

there are a few caveats such as i cannot come over if my car is broken down or i cannot get off work but i will not list them all as that would be silly
SO ITS YOUR BIRTHDAY

my $crypt = Crypt::NQR13_f::encode($message);
$crypt =~ s/!/\n\n/g;
say "Level 1 `encryption': $crypt";

my $mapping = Crypt::NQR13_f::generate_mapping;
use Data::Dump 'pp';
print 'mapping: ';
say pp $mapping;
$crypt = Crypt::NQR13_f::tr_with_mapping($mapping, $crypt);
say "Level 2 `encryption': $crypt";

$crypt = Crypt::NQR13_f::orbfuscate($crypt);
say "Level 3 `encryption': $crypt";


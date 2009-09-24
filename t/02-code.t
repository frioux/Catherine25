#!perl

use strict;
use warnings;
use Test::More 'no_plan';

use Crypt::NQR13_f;
use utf8;

my $message = 'a frew is weird';
my ($encoded, $mapping) = Crypt::NQR13_f::encode($message);
like $encoded, qr/XaZ w[er]{2}f sYi d[eir]{3}w/, 'encoding works';

$message = Crypt::NQR13_f::decode($encoded);
is $message, 'a ferw is weird',  'decoding works';
my $mapping = Crypt::NQR13_f::generate_mapping;
my $tr_frew = Crypt::NQR13_f::tr_with_mapping($mapping, 'frew');
my $untr_frew = Crypt::NQR13_f::untr_with_mapping($mapping, $tr_frew);
cmp_ok $tr_frew, 'ne', $untr_frew, q{tr'd strings are different};
is $untr_frew, 'frew', 'tr goes both ways correctly';
my $obd = Crypt::NQR13_f::orbfuscate('this is a complex mapping!');
is Crypt::NQR13_f::unorbfuscate($obd), 'this is a complex mapping!', 'unob works';

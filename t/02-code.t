#!perl

use strict;
use warnings;
use Test::More 'no_plan';

use Crypt::NQR13_f;

my $message = 'a frew is weird';
my $encoded = Crypt::NQR13_f::encode($message);
like $encoded, qr/XaZ w[er]{2}f sYi d[eir]{3}w/, 'encoding works';

$message = Crypt::NQR13_f::decode($encoded);
is $message, 'a ferw is weird',  'decoding works';

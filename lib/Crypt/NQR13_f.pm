package Crypt::NQR13_f;
use signatures;
use List::Util 'shuffle';
use List::MoreUtils 'zip';
use feature ':5.10';
use utf8;
use strict;
use warnings;

sub generate_mapping {
   my @alphabet = ('a'..'z');
   my @random   = shuffle ('a'..'z');
   return { zip @alphabet, @random };
}

sub tr_with_mapping ($mapping, $_) {
   my $from = join q{}, keys %{$mapping};
   my $to = join q{}, values %{$mapping};
   eval "tr/$from/$to/";
   $_;
}

sub untr_with_mapping ($mapping, $_) {
   my $to = join q{}, keys %{$mapping};
   my $from = join q{}, values %{$mapping};
   eval "tr/$from/$to/";
   $_;
}

sub encode_word ($word) {
   given (length $word) {
      when (0) {}
      when (1) { $word = "X${word}Z"; }
      when (2) { $word =~ s/^(.)(.)$/$2Y$1/; } # boobs!
      default {
         $word =~ /^(.)(.*?)(.)?$/; # get first and last characters
         $word = $3.(join q{}, shuffle split q{}, $2).$1;
      }
   }
   return $word;
}

sub encode ($message) {
   my @sentances =
   my @words =  lc $message;
   return join qq{\n}, map { join q{ }, map encode_word($_), split / /} split /\n/, lc $message;
}

sub decode_word ($word) {
   given ($word) {
      when (0) {}
      when (qr/X(.)Z/) { $word = $1; }
      when (qr/(.)Y(.)/) { $word = $2.$1; } # boobs!
      default {
         $word =~ /^(.)(.*?)(.)?$/; # get first and last characters
         $word = $3.(join q{}, sort split q{}, $2).$1;
      }
   }
   return $word;
}

sub decode ($unmessage) {
   my @words = map decode_word($_), split /\s/, $unmessage;
   return join q{ }, @words;
}

my $ob_mapping = {
   a => 'ठ',
   b => 'अ',
   c => 'इ',
   d => 'उ',
   e => 'ऋ',
   f => 'ए',
   g => 'क',
   h => 'ख',
   i => 'ग',
   j => 'घ',
   k => 'ङ',
   l => 'च',
   m => 'छ',
   n => 'ज',
   o => 'झ',
   p => 'ञ',
   q => 'ट',
   r => 'ब',
   s => 'ड',
   t => 'ढ',
   u => 'ण',
   v => 'त',
   w => 'थ',
   x => 'द',
   y => 'ध',
   z => 'न',
};

my @keys = keys %{$ob_mapping};
my @values = values %{$ob_mapping};
my $unob_mapping = { zip @values, @keys };

sub orbfuscate ($message) {
   return tr_with_mapping $ob_mapping, $message;
}

sub unorbfuscate ($message) {
   return tr_with_mapping $unob_mapping, $message;
}

"for catherine";

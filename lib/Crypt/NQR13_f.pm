package Crypt::NQR13_f;
use signatures;
use List::Util 'shuffle';
use feature ':5.10';

use constant {
   START  => q{X},
   MIDDLE => q{Y},
   ENDING => q{Z},
};

sub encode_word ($word) {
   given (length $word) {
      when (0) {}
      when (1) { $word = START.$word.ENDING; }
      when (2) { $word =~ s/^(.)(.)$/$2Y$1/; } # boobs!
      default {
         $word =~ /^(.)(.*?)(.)?$/; # get first and last characters
         $word = $3.(join q{}, shuffle split q{}, $2).$1;
      }
   }
   return $word;
}

sub encode ($message) {
   my @words = map encode_word($_), split /\s/, $message;
   return join q{ }, @words;
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

"for catherine";

use strict;
use Test::More 0.98 tests => 3;

use_ok $_ for qw(
  Amanzon::Echo::Response::Response::OutputSpeech
);

my $card = Amanzon::Echo::Response::Response::OutputSpeech->new(
    text => 'test text',

);

is( $card->type, 'PlainText', "right default output speech type" );
is( $card->text, 'test text' );

done_testing;

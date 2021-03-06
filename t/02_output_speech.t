use strict;
use Test::More 0.98 tests => 4;

use_ok $_ for qw(
  Amazon::Echo::Response::Response::OutputSpeech
);

my $speech = Amazon::Echo::Response::Response::OutputSpeech->new(
    text => 'test text',

);

is( $speech->type, 'PlainText', "right default output speech type" );
is( $speech->text, 'test text' );
is_deeply( $speech->TO_JSON, { text => 'test text', type => 'PlainText' } );


use strict;
use Test::More tests => 4;

use_ok $_ for qw(
  Amazon::Echo::Request::Session
);

my $json = {
    "new" => 0,
    "sessionId" =>
      "amzn1.echo-api.session.abeee1a7-aee0-41e6-8192-e6faaed9f5ef",
    "attributes" => {
        "supportedHoroscopePeriods" => {
            "daily"   => 1,
            "weekly"  => 1,
            "monthly" => 1
        },
    },
};

my $session = Amazon::Echo::Request::Session->new($json);
is( $session->is_new,     0,                   'not new' );
is( $session->sessionId, $json->{sessionId},  'right session id' );
is( $session->attributes, $json->{attributes}, 'right attributes' );


use strict;
use Test::More tests => 5;

use_ok $_ for qw(
  Amanzon::Echo::Request::Session
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

my $session = Amanzon::Echo::Request::Session->new($json);
is_deeply( $session->json, $json, "get the same json" );
is( $session->is_new,     0,                   'not new' );
is( $session->session_id, $json->{sessionId},  'right session id' );
is( $session->attributes, $json->{attributes}, 'right attributes' );


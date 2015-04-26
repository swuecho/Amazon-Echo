use strict;
use Test::More tests => 5;

use_ok $_ for qw(
  Amazon::Echo::Request::Request::IntentRequest
);

my $json = {
    "type" => "IntentRequest",
    "requestId" =>
      " amzn1.echo-api.request.6919844a-733e-4e89-893a-fdcb77e2ef0d",
    "intent" => {
        "name"  => "GetZodiacHoroscopeIntent",
        "slots" => {
            "ZodiacSign" => {
                "name"  => "ZodiacSign",
                "value" => "virgo"
            }
        }
    }
};

my $req = Amazon::Echo::Request::Request::IntentRequest->new($json);
is_deeply( $req->json, $json, "get the same json" );
is( $req->type,       $json->{type},      'not new' );
is( $req->request_id, $json->{requestId}, 'right request id' );
is( $req->intent,     $json->{intent},    'right intent' );


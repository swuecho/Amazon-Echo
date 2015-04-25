use strict;
use Test::More tests => 4;

use_ok $_ for qw(
  Amanzon::Echo::Request::Request::LaunchRequest
);

my $json = {
    "type" => "LaunchRequest",
    "requestId" =>
      "amzn1.echo-api.request.d8c37cd6-0e1c-458e-8877-5bb4160bf1e1",
};

my $req = Amanzon::Echo::Request::Request::LaunchRequest->new($json);
is_deeply( $req->json, $json, "get the same json" );
is( $req->type,       $json->{type},      'lanch request' );
is( $req->request_id, $json->{requestId}, 'right request id' );


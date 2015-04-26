use strict;
use Test::More tests => 3;

use_ok $_ for qw(
  Amazon::Echo::Request::Request::LaunchRequest
);

my $json = {
    "type" => "LaunchRequest",
    "requestId" =>
      "amzn1.echo-api.request.d8c37cd6-0e1c-458e-8877-5bb4160bf1e1",
};

my $req = Amazon::Echo::Request::Request::LaunchRequest->new($json);
is( $req->type,       $json->{type},      'lanch request' );
is( $req->requestId, $json->{requestId}, 'right request id' );


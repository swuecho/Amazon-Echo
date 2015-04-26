use Test::More tests => 1;

use JSON::XS;
use Plack::Test;

use Amazon::Echo::Request;

my $text = "Your luck number is 100";
my $response_json =
q|{"version":"1.0","response":{"shouldEndSession":false,"outputSpeech":{"text":"Your luck number is 100","type":"PlainText"}}}|;

# the sub is the app
my $app = sub {

    # PSGI env
    my $env = shift;
    my $req = Amazon::Echo::Request->new($env);
    my $res = $req->response();
    $res->speech_text($text);
    $res->finalize_response;
};

my $test = Plack::Test->create($app);
my $req  = HTTP::Request->new( POST => '/' );
my $res  = $test->request($req);
is_deeply(
    decode_json( $res->content ),
    decode_json($response_json),
    'get right response'
);


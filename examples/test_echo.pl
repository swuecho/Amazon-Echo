use lib '/home/hwu/Amazon-Echo/lib/';
use Amazon::Echo::Request;
use Amazon::Echo::Response::Response;
use Amazon::Echo::Response::Response::Card;
use Amazon::Echo::Response::Response::OutputSpeech;
use JSON::XS;
use DDP;
my $rand     = int rand(100);

my $card = Amazon::Echo::Response::Response::Card->new(
                "title"    => "Lucky Number",
                "subtitle" => "random",
                "content"  => $rand,
            );

my $speech= Amazon::Echo::Response::Response::OutputSpeech->new(
             "text" => "Your luck number is $rand"
);

# generate response
 my $response = Amazon::Echo::Response::Response->new( 
            "outputSpeech" => $speech,
            "card" => $card,
            "shouldEndSession" => \0
 );


# the sub is the app
sub {
    # PSGI env
    my $env = shift;
    my $req = Amazon::Echo::Request->new($env);
    my $res = $req->response();  
    $res->response($response);
    $res->finalize_response;
};

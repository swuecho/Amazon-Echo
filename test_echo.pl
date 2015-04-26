use lib '/home/hwu/Amazon-Echo/lib/';
use Amazon::Echo::Request;
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

p $card->TO_JSON;
p $speech->TO_JSON;


# generate response
sub get_response {
    my $response = {
            "outputSpeech" => $speech,
            "card" => $card,
            "shouldEndSession" => \1
    };

    return $response;
}

# the sub is the app
sub {
    # PSGI env
    my $env = shift;

    my $req = Amazon::Echo::Request->new($env);

    my $res = $req->response();    # new Plack::Response
    p $res;
    $res->response(get_response);
         #Content-Type: application/json;charset=UTF-8
    #$res->content_type('application/json');
    #$res->header( charset => 'UTF-8' );
    #my $json = get_response_json();
    #$res->body($json);
    #$res->content_length( length $json );
    $res->finalize_response;
};

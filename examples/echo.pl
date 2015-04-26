use DDP;
use MongoDB;
use Amazon::Echo::Request;

my $client = MongoDB::MongoClient->new( host => 'localhost', port => 27017 );
my $database = $client->get_database('echo');
my $collection = $database->get_collection('request');


# the sub is the app
sub {
    # PSGI env
    my $env = shift;
    my $req = Amazon::Echo::Request->new($env);
    $collection->insert( $req->json ) ;
    my $res = $req->response();  
    my $text;
    # if request is new and is a launch request
    if ($req->is_new and $req->type eq 'LaunchRequest') { 
      $text = 'what do you want me to do';
    # if request is new and is a launch request
    } elsif ($req->type eq 'IntentRequest')  {
      $text = $req->intent->{name}; 
    } else {
      $text = 'not a luanch request';
    }
    use DDP; p $text;
    $res->speech_text($text);
    $res->finalize_response;
};

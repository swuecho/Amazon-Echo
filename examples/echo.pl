use MongoDB;
use Amazon::Echo::Request;
use List::MoreUtils qw(zip);
use WebService::HackerNews;

# mongodb
my $client = MongoDB::MongoClient->new( host => 'localhost', port => 27017 );
my $database = $client->get_database('echo');
my $collection = $database->get_collection('request');

# fetch hacker news
# hacknew takes too much time to fetch, have to have a cron job to fetch ahead
# TOOD: write  a systemd service and run every hours 
# 
sub hn_top_5 {
    my $hn          = WebService::HackerNews->new;
    my @top100      = $hn->top_story_ids;
    my @top10_items = map { $hn->item($_)->title } @top100[ 0 .. 4 ];
    my @one_to_five = ( 1 .. 5 );
    my $top_5       = join( "\n", zip @one_to_five, @top10_items );
    return $top_5;
}

# the sub is the app
sub {
    # PSGI env
    my $env = shift;
    my $req = Amazon::Echo::Request->new($env);
    $collection->insert( $req->json );
    my $res = $req->response();
    my $text;
    # if request is new and is a launch request
    if ( $req->is_new and $req->type eq 'LaunchRequest' ) {
        $text = 'what do you want me to do';

        # if request is new and is a launch request
    }
    elsif ( $req->type eq 'IntentRequest' ) {
        use DDP; p $req->intent;
        if ( $text = $req->intent->{name} eq 'HackerNews' ) {
            $text = "1\nRace conditions on Facebook, DigitalOcean and others (fixed)\n2\nDocker without Docker\n3\nRandom Points on a Sphere\n4\nWhite House Takes Security Pitch to Silicon Valley\n5\nWhy can’t we read anymore?";
        }
        else {
            $text = $req->intent->{name};
        }
    }
    else {
        $text = 'not a luanch request';
    }
    use DDP; p $text;
    $res->speech_text($text);
    $res->finalize_response;
};

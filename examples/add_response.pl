use Amazon::Echo::Request;

sub text {
	my $rand     = int rand(100);
	my $text = "Your luck number is $rand";
	return $text
}

# the sub is the app
sub {
    # PSGI env
    my $env = shift;
    my $req = Amazon::Echo::Request->new($env);
    my $res = $req->response();  
    $res->speech_text(text);
    $res->finalize_response;
};

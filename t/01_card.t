use strict;
use Test::More tests => 4;

use_ok $_ for qw(
  Amazon::Echo::Response::Response::Card
);

my $json = {
    title    => 'test title',
    subtitle => 'test subtitle',
    content  => 'test content',
};

my $card = Amazon::Echo::Response::Response::Card->new($json);

is( $card->type, 'Simple', "right default card type" );
is( $card->title, 'test title' );
is( $card->TO_JSON->{type}, 'Simple', 'test title' );


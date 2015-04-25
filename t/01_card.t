use strict;
use Test::More tests => 3;

use_ok $_ for qw(
  Amanzon::Echo::Response::Response::Card
);

my $card = Amanzon::Echo::Response::Response::Card->new(
    title    => 'test title',
    subtitle => 'test subtitle',
    content  => 'test content',

);

is( $card->type, 'Simple', "right default card type" );
is( $card->title, 'test title' );


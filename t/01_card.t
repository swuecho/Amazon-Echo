use strict;
use Test::More 0.98;

use_ok $_ for qw(
  Amanzon::Echo::Response::Response::Card
);

my $card = Amanzon::Echo::Response::Response::Card->new(
	title => 'test title',
	subtitle => 'test subtitle',
	content => 'test content',

);

cmp_ok(card->type, 'Simple');
cmp_ok(card->title, 'test title');

done_testing;


use v5.20;
use WebService::HackerNews;
my $hn     = WebService::HackerNews->new;
my @top100 = $hn->top_story_ids;
my @top10_items   = map { $hn->item($_)  } @top100[0..4];
my $top_5_text = join("\n\n", @top10_items);

package Amazon::Echo::TOJSON;
use Moose::Role;

sub TO_JSON {
    my $self = shift;

    #do not sererailze private attr, and only serialize the attr with a value
    my %href = map {
            $_->name =~ /^_/ ? ()
          : $_->has_value($self) ? ( $_->name => $_->get_value($self) )
          : ()
    } $self->meta->get_all_attributes;
    return \%href;

}

1;

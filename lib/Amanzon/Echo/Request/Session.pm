package Amanzon::Echo::Request::Session;
use 5.008001;
use Moose;

our $VERSION = "0.01";

=for comment
  "session": {
    "new": 'boolean',
    "sessionId": "string",
    "attributes": {
      "string": object
    },
    "user": {
      "userId": "string"
    }
}
=cut

sub BUILDARGS {
    my ( $class, $json ) = @_;
    return { json => $json, };
}

has 'json' => ( isa => 'HashRef', is => 'ro' );

has 'is_new' => (
    isa     => 'Bool',
    is      => 'rw',
    lazy    => 1,
    builder => sub {
        shift->json->{new};
    }
);

has 'session_id' => (
    isa     => 'Str',
    is      => 'rw',
    lazy    => 1,
    builder => sub {
        shift->json->{sessionId};
    }
);

has 'attributes' => (
    isa     => 'HashRef',
    is      => 'rw',
    lazy    => 1,
    builder => sub { shift->json->{attributes} // {} }
);

has 'user' => (
    isa     => 'HashRef',
    is      => 'rw',
    lazy    => 1,
    builder => sub { shift->json->{User} // {} }
);

1;
__END__

=encoding utf-8

=head1 NAME

Amanzon::Echo - It's new $module

=head1 SYNOPSIS

    use Amanzon::Echo;

=head1 DESCRIPTION

Amanzon::Echo is ...

=head1 LICENSE

Copyright (C) Hao Wu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hao Wu E<lt>echowuhao@gmail.comE<gt>

=cut


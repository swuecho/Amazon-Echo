package Amazon::Echo::Request::Session;
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

# change the name new to is_new
# because moose provides a new method by default
around BUILDARGS => sub {
    my ( $orig, $class, $request_href ) = @_;
    return $class->$orig( is_new => $request_href->{new}, %$request_href );
};

has 'is_new' => (
    isa => 'Bool',
    is  => 'ro',
);

has 'sessionId' => (
    isa => 'Str',
    is  => 'ro',
);

has 'attributes' => (
    isa => 'Maybe[HashRef]',
    is  => 'ro',
);

has 'user' => (
    isa => 'HashRef',
    is  => 'ro',
);

1;
__END__

=encoding utf-8

=head1 NAME

Amazon::Echo - It's new $module

=head1 SYNOPSIS

    use Amazon::Echo;

=head1 DESCRIPTION

Amazon::Echo is ...

=head1 LICENSE

Copyright (C) Hao Wu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hao Wu E<lt>echowuhao@gmail.comE<gt>

=cut


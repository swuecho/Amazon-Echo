package Amanzon::Echo::Request::Request::SessionEndedRequest;
use 5.008001;
use Moose;

our $VERSION = "0.01";

=for comment
{
  "type": "string",
  "requestId": "string",
  "reason": "string"
}
=cut

sub BUILDARGS {
    my ( $class, $json ) = @_;
    return { json => $json, };
}

has 'json' => ( isa => 'HashRef', is => 'ro' );

has 'type' => ( isa => 'Str', is => 'ro', default => 'SessionEndedRequest' );
has 'request_id' => (
    isa     => 'Str',
    is      => 'rw',
    lazy    => 1,
    default => sub {
        shift->json->{requestId};
    }
);

# USER_INITIATED – Indicates that the user explicitly ended the session.
# ERROR – Indicates that an error occurred that caused the session to end.
# EXCEEDED_MAX_REPROMPTS - Indicates that the user either did not respond
# or responded with an utterance that did not match any of your app’s intents |
has 'reason' => (
    isa     => 'Str',
    is      => 'rw',
    lazy    => 1,
    default => sub {
        shift->json->{resaon};
    }
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


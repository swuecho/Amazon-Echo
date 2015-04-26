package Amazon::Echo::Request;
use 5.008001;
use Moose;
use Plack::Request;
use JSON::XS;
use Amazon::Echo::Request::Session;
use Amazon::Echo::Request::Request::LaunchRequest;
use Amazon::Echo::Request::Request::IntentRequest;
use Amazon::Echo::Request::Request::SessionEndedRequest;

our $VERSION = "0.01";

=for comment
{
  "version": "string",
  "session": {
    "new": 'boolean',
    "sessionId": "string",
    "attributes": {
      "string": object
    },
    "user": {
      "userId": "string"
    }
  },
  "request": object
}
=cut

sub BUILDARGS {
    my ( $class, $env ) = @_;
    my $plack_request = Plack::Request->new($env);

    return { _plack_request => $plack_request, };
}

has '_plack_request' => (
    isa     => 'Plack::Request',
    is      => 'rw',
    handles => [
        qw(address base content body content_encoding content_length content_type env header headers method
          param parameters path path_info protocol referer remote_host request_uri scheme script_name new_response
          secure upload uploads uri user_agent)
    ],
);

has 'string' =>
  ( isa => 'Str', is => 'ro', lazy => 1, builder => '_build_string' );

sub _build_string {
    my $self = shift;
    my $echo_request_str;
    die "not a post request" if $self->method ne 'POST';
    $self->body->read( $echo_request_str, $self->content_length );
    return $echo_request_str;

}

#TODO: buid a JSON type
has 'json' =>
  ( isa => 'HashRef', is => 'ro', lazy => 1, builder => '_build_json' );

sub _build_json {
    my $self = shift;

    #todo: uft8
    my $echo_request = decode_json( $self->string );
    return $echo_request;
}

has 'version' => (
    isa     => 'Str',
    is      => 'ro',
    lazy    => 1,
    default => sub { shift->json->version }
);

has 'session' => (
    isa  => 'Amazon::Echo::Request::Session',
    is   => 'ro',
    lazy => 1,
    default =>
      sub { Amazon::Echo::Request::Session->new( shift->json->{session} ) },
    handles => [qw(is_new)]
);

has 'request' => (

    #simplify the type enum
    isa =>
'Amazon::Echo::Request::Request::LaunchRequest|Amazon::Echo::Request::Request::IntentRequest|Amazon::Echo::Request::Request::SessionEndedRequest',
    is      => 'rw',
    lazy    => 1,
    builder => '_build_request',
    handles => [qw(type intent)]
);

sub _build_request {
    my $request_json = shift->json->{request};
    my $request_type = $request_json->{type};

    #TODO: request type error?
    if ( $request_type eq 'LaunchRequest' ) {
        Amazon::Echo::Request::Request::LaunchRequest->new($request_json);
    }
    elsif ( $request_type eq 'IntentRequest' ) {
        Amazon::Echo::Request::Request::IntentRequest->new($request_json);
    }
    else {
        Amazon::Echo::Request::Request::SessionEndedRequest->new($request_json);
    }
}

sub response {
    my $self = shift;
    require Amazon::Echo::Response;
    return Amazon::Echo::Response->new(@_);
}
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


package Amanzon::Echo::Request;
use 5.008001;
use Moose;
use Plack::Request;
use JSON::XS;

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

#    my $echo_request_str;
#    $placek_request->body->read( $echo_request_str,
#        $plack_request->content_length );
#    my $echo_request = decode_json($echo_request_str);
#    my $session = $echo_request->session;    # bless it into Request Session
#    my $echo_request_request =  $echo_request->request;  # bless it into Request Session
    return {
        _plack_request => $plack_request,

        #        version        => $echo_request->version,
        #        session        => $session,
        #        request        => $echo_request_request,
    };
}

has '_plack_request' => (
    isa     => 'Plack::Request',
    is      => 'rw',
    handles => [
        qw(address base content content_encoding content_length content_type env header headers method
          param parameters path path_info protocol referer remote_host request_uri scheme script_name
          secure upload uploads uri user_agent)
    ],
);

has 'string' =>
  ( isa => 'Str', is => 'ro', lazy => 1, builder => '_build_string' );

sub _build_string {
    my $self = shift;
    my $echo_request_str;
    $self->body->read( $echo_request_str, $self->content_length );
    return $echo_request_str;

}

has 'json' => ( isa => 'Str', is => 'ro', lazy => 1, builder => '_build_json' );

sub _build_request_str {
    my $self         = shift;
    my $echo_request = decode_json($echo_request_str);
    return $recho_request;
}

has 'version' => (
    isa     => 'Str',
    is      => 'ro',
    lazy    => 1,
    builder => sub { shift->json->version }
);

has 'session' => (
    isa  => 'Amazon::Echo::Request::Session',
    is   => 'ro',
    lazy => 1,
    builder =>
      sub { Amazon::Echo::Request::Session->new( shift->json->{session} ) }
);

has 'request' => (

    #simplify the type enum
    isa =>
'Amazon::Echo::Request::LaunchRequest|Amazon::Echo::Request::IntentRequest|Amazon::Echo::Request::SessionEndedRequest',
    is      => 'rw',
    lazy    => 1,
    builder => '_build_request',
);

sub _build_request {
    my $request_json = shift->json->{request};
    my $request_type = request_json->{type};
    if ( $request_type eq 'LaunchRequest' ) {
        Amazon::Echo::Request::LaunchRequest->new();
    }
    elsif ( $request_type eq 'IntentRequest' ) {
        Amazon::Echo::Request::IntentRequest->new();
    }
    else {
        Amazon::Echo::Request::SessionEndedRequest->new();
    }
}

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


package Amanzon::Echo::Request;
use 5.008001;
use Moose;
use Plack::Response;
use JSON::XS;

our $VERSION = "0.01";

=for comment
{
  "version": "string",
  "sessionAttributes": {
    "string": object
  },
  "response": {
    "outputSpeech": {
      "type": "string",
      "text": "string"
    },
    "card": {
      "type": "string",
      "title": "string",
      "subtitle": "string",
      "content": "string"
    },
    "shouldEndSession": boolean
  }
}


    $res->content_type('application/json');
    $res->header( charset => 'UTF-8' );
    my $json = get_response_json();
    $res->body($json);
    $res->content_length( length $json );
=cut

has 'string' =>
  ( isa => 'Str', is => 'ro', lazy => 1, builder => '_build_string' );

sub _build_string {
    my $self = shift;
    my $echo_request_str;
    $self->body->read( $echo_request_str, $self->content_length );
    return $echo_request_str;

}

sub finialize_repsone {
    my $self = shift;
    $self->content_type('application/json');
    $self->header( charset => 'UTF-8' );
    my $string = $self->string;
    $self->content_length( length $json );
    $self->body($string);
    $self->finalize;
}

has '_plack_response' => (
    isa     => 'Plack::Response',
    is      => 'rw',
    handles => [
        qw(address base content content_encoding content_length content_type env header headers method
          param parameters path path_info protocol referer remote_host request_uri scheme script_name)
);

has 'version' => (
    isa     => 'Str',
    is      => 'ro',
    default => '1.0',
    #required => 1
);

has 'session_attributes' => (
#   isa  => 'Hashref',
    is   => 'ro',
);

has 'resoponse' => (
    is   => 'ro',
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

Hao Wu E<lt>hwu@intellisurvey.comE<gt>

=cut


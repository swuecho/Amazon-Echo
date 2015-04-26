package Amazon::Echo::Response;
use 5.008001;
use Moose;
use Plack::Response;
use Amazon::Echo::Response::Response;
use JSON::XS;
our $VERSION = "0.01";

with 'Amazon::Echo::TOJSON';
my $json = JSON::XS->new->convert_blessed(1);

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

=cut

sub BUILDARGS {
    my $class          = shift;
    my $plack_response = Plack::Response->new(200);
    return { _plack_response => $plack_response };
}

has '_plack_response' => (
    isa     => 'Plack::Response',
    is      => 'rw',
    handles => [qw(header content_length content_type body finalize )]
);

sub finalize_response {
    my $self = shift;
    $self->content_type('application/json');
    $self->header( charset => 'UTF-8' );

    # encode $self to a json string
    my $string = $json->encode($self);
    $self->content_length( length $string );
    $self->body($string);
    $self->finalize;
}

has 'version' => (
    isa     => 'Str',
    is      => 'ro',
    default => '1.0',

    #required => 1
);

has 'sessionAttributes' => (
    isa => 'Hashref',
    is  => 'ro',
);

has 'response' => (
    isa     => 'Amazon::Echo::Response::Response',
    is      => 'rw',
    handles => { speech_text => 'speech_text' },
    default => sub { Amazon::Echo::Response::Response->new() }
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


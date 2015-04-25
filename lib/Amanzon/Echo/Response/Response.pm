package Amanzon::Echo::Response::Response;
use 5.008001;
use Moose;

our $VERSION = "0.01";

=for comment
"response": {
    "outputSpeech": {
      "type": "PlainText",
      "text": "Today will provide you a new learning opportunity.  Stick with it and the possibilities will be endless."
    },
    "card": {
      "type": "Simple",
      "title": "Horoscope",
      "subtitle": "Virgo - Daily",
      "content": "Today will provide you a new learning opportunity.  Stick with it and the possibilities will be endless."
    },
    "shouldEndSession": true
  }
=cut

has 'card' => ( isa => 'Amazon::Echo::Response::Response::Card', is => 'rw' );
has 'output_speech' =>
  ( isa => 'Amazon::Echo::Response::Response::OutputSpeech', is => 'rw' );
has 'should_end_session ' => ( isa => 'Bool', is => 'rw' );

sub TO_JSON {
    my $self = shift;
    return {
        ouputSpeech      => $self->output_speech,
        card             => $self->card,
        shouldEndSession => $self->should_end_session
    };
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


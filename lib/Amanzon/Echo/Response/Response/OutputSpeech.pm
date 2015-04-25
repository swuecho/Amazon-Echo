package Amanzon::Echo::Response::Response::OutputSpeech;
use 5.008001;
use Moose;

our $VERSION = "0.01";

=for comment

"outputSpeech": {
      "type": "string",
      "text": "string"
    },

=cut

has 'type' => ( isa => 'Str', is => 'ro', default => 'PlainText' );
has 'text' => ( isa => 'Str', is => 'ro' );

# try to be smart,proivde a default to every method
sub TO_JSON {
    my $self = shift;
    return {
        "type" => $self->type,
        "text" => $self->text,
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


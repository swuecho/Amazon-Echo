package Amanzon::Echo::Request::SessionEndedRequest;
use 5.008001;
use Moose;

extends 'Amanzon::Echo::Request::IntentRequest';

our $VERSION = "0.01";

=for comment
{
  "type": "string",
  "requestId": "string"
}
=cut

has 'type' => ( isa => 'Str', is => 'ro' );
has 'request_id' => ( isa => 'Str', is => 'ro' );
has 'reason' => ( isa => 'Str', is => 'ro' );

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


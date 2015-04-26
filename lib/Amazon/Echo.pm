package Amazon::Echo;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";
use Moose::Util::TypeConstraints;

subtype 'Natural', as 'Int', where { $_ > 0 };

subtype 'NaturalLessThanTen', as 'Natural',
  where { $_ < 10 },
  message { "This number ($_) is not less than ten!" };

class_type 'DateTimeClass', { class => 'DateTime' };

#role_type 'Barks', { role => 'Some::Library::Role::Barks' };

enum 'Request', [qw(red green blue)];

union 'StringOrArray', [qw( Str ArrayRef )];

no Moose::Util::TypeConstraints;

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


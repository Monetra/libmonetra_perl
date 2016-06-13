package MCVE;

use strict;
use warnings;
#use Carp;

#require Exporter;
#require DynaLoader;
use Monetra ':all';

our @ISA = qw(Exporter Monetra);

our $VERSION = '0.9.4';

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
=head1 NAME

MCVE - Perl extension for interfacing with Monetra - C module 

=head1 SYNOPSIS

  use MCVE;

  See test.pl for example usage.

=head1 DESCRIPTION

Extension to interface with libmonetra C-module from Perl. 

=head2 EXPORT

None by default.

=head2 Exportable constants

=head2 Exportable functions

=head1 AUTHOR

    Brad House
    CPAN ID: MODAUTHOR
    Main Street Softworks
    support@monetra.com
    http://www.monetra.com

=head1 SEE ALSO

L<perl>.

=cut

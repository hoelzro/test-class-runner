package Test::Class::Runner::Util;

use strict;
use warnings;
use parent 'Exporter';

our @EXPORT_OK = qw(load_module);

sub load_module {
    my ( $module ) = @_;

    $module =~ s{::}{/}g;
    $module .= '.pm';

    require $module;
}

1;

__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

=cut

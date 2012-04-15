package Test::Class::Runner::Metadata;

use strict;
use warnings;

require Test::Class;

sub new {
    my ( $class, $test_class ) = @_;

    return bless {
        test_class => $test_class,
    }, $class;
}

sub test_classes {
    my ( $self ) = @_;

    # for now
    return ( $self->{'test_class'} );
}

sub test_methods {
    my ( $self, $test_class ) = @_;

    # XXX this interface may change in the future; I'm hoping
    #     that after writing this distribution, I can help
    #     convince the Test::Class author to offer an introspection
    #     API =)
    return Test::Class::_get_methods($test_class, Test::Class::TEST());
}

1;

__END__

# ABSTRACT: 

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

=cut

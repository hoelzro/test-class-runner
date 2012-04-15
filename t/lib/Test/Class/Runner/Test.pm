package Test::Class::Runner::Test;

use strict;
use warnings;
use parent 'Test::Class::Runner';

sub show_tests {
    my ( $self, $metadata ) = @_;

    $self->{'post_run'}->($metadata);
}

1;

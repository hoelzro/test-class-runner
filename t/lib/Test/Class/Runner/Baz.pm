package Test::Class::Runner::Baz;

use strict;
use warnings;
use parent 'Test::Class::Runner';

sub roles {
    return qw(baz);
}

sub precedence {
    return 0.5;
}


1;

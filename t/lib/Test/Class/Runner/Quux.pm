package Test::Class::Runner::Quux;

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

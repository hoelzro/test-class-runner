package Test::Class::Runner::Bar;

use strict;
use warnings;
use parent 'Test::Class::Runner';

sub roles {
    return qw(foo bar);
}

sub precedence {
    return 0.8;
}

1;

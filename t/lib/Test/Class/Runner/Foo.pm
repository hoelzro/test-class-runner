package Test::Class::Runner::Foo;

use strict;
use warnings;
use parent 'Test::Class::Runner';

sub roles {
    return qw(foo);
}

sub precedence {
    return 1.0;
}

1;

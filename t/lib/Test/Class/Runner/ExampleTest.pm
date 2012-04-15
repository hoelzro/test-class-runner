package Test::Class::Runner::ExampleTest;

use strict;
use warnings;
use parent 'Test::Class';

use Test::More;

sub test_one :Test(1) {
    pass;
}

sub test_two :Test(1) {
    fail;
}

sub test_three :Test(1) {
    pass;
}

1;

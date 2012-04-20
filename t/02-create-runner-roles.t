use strict;
use warnings;
use lib 't/lib';
use parent 'Test::Class';

use Test::Class::TestRunner;
use Test::More;

sub _test_roles {
    my ( $self, $roles, $runner_type ) = @_;

    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $factory = Test::Class::TestRunner->new({
        roles => $roles,
    });

    my $runner = $factory->create_runner;

    if(defined $runner_type) {
        isa_ok $runner, 'Test::Class::Runner::' . $runner_type;
    } else {
        ok !defined($runner);
    }
}

sub test_single_role :Test {
    my ( $self ) = @_;

    $self->_test_roles(['foo'], 'Foo');
}

sub test_multiple_roles_one_match :Test {
    my ( $self ) = @_;

    $self->_test_roles(['foo', 'missing'], 'Foo');
}

sub test_multiple_roles_all_match :Test {
    my ( $self ) = @_;

    $self->_test_roles(['foo', 'bar'], 'Bar');
}

sub test_role_with_no_match :Test {
    my ( $self ) = @_;

    $self->_test_roles(['missing'], undef);
}

__PACKAGE__->runtests;

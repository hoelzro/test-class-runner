use strict;
use warnings;
use parent 'Test::Class';
use lib 't/lib';

use Test::Class::Runner::Test;
use Test::More;

sub create_runner {
    return Test::Class::Runner::Test->new({});
}

# a_ prefix so we load this test first
sub a_test_load_module :Test(2) {
    my ( $self ) = @_;

    my $runner = $self->create_runner;

    ok !exists $Test::Class::Runner::{'ExampleTest::'};

    $runner->load_module('Test::Class::Runner::ExampleTest');

    ok exists $Test::Class::Runner::{'ExampleTest::'};
}

sub test_get_test_metadata :Test(2) {
    my ( $self ) = @_;

    my $runner       = $self->create_runner;
    my $meta         = $runner->get_test_metadata('Test::Class::Runner::ExampleTest');
    my @test_classes = $meta->test_classes;

    is_deeply \@test_classes, ['Test::Class::Runner::ExampleTest'];

    my @test_methods = $meta->test_methods('Test::Class::Runner::ExampleTest');

    @test_methods = sort @test_methods;

    is_deeply \@test_methods, [sort qw{test_one test_two test_three}];
}

sub test_run_test_method :Test(3) {
    my ( $self ) = @_;

    my $test_class = 'Test::Class::Runner::ExampleTest';
    my $runner     = $self->create_runner;

    $runner->load_module($test_class);

    my $results;

    $results = $runner->run_test_method($test_class, 'test_one');

    ok $results->all_passed;

    $results = $runner->run_test_method($test_class, 'test_two');

    ok !$results->all_passed;

    $results = $runner->run_test_method($test_class, 'test_three');

    ok $results->all_passed;
}

__PACKAGE__->runtests;

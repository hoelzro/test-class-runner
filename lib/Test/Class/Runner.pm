## no critic (RequireUseStrict)
package Test::Class::Runner;

## use critic (RequireUseStrict)
use strict;
use warnings;
use autodie qw(fork pipe);

use Carp qw(croak);

use TAP::Harness;
use Test::Class::Runner::Metadata;
use Test::Class::Runner::Util qw(load_module);

use namespace::clean;

sub new {
    my ( $class, $options ) = @_;

    return bless {
    }, $class;
}

sub _is_module {
    my ( $self, $file_or_module ) = @_;

    return 1 if $file_or_module =~ /::/;
    return 0 if $file_or_module =~ m{/|\\};
    return 0 if $file_or_module =~ /\.(t|pl)$/;
    return 1;
}

sub run_test_method {
    my ( $self, $class, $method ) = @_;

    my ( $read, $write );

    pipe $read, $write;

    my $pid = fork;

    if($pid) {
        close $write;
        my $tap = TAP::Harness->new({
            verbosity => -3, # XXX magic number
        });
        my $results = $tap->runtests($read);
        waitpid $pid, 0;
        return $results;
    } else {
        close $read;
        # XXX platform-specific
        open STDOUT, '>', '/dev/null';
        open STDERR, '>', '/dev/null';

        # XXX this is fragile
        my $builder = Test::Class->builder;

        $builder->reset; # reset the current Test::Builder plan if we're being
                         # tested
        $builder->output($write);
        $builder->failure_output($write);
        $builder->todo_output($write);

        # XXX what if I have SuperClass::test_foo and SubClass::test_foo?
        Test::Class->add_filter(sub {
            my ( undef, $current_method ) = @_;

            return $method eq $current_method;
        });
        Test::Class->runtests($class);
        exit 0;
    }
}

sub get_test_metadata {
    my ( $self, $test_module ) = @_;

    return Test::Class::Runner::Metadata->new($test_module);
}

sub _run_test_module {
    my ( $self, $test_module ) = @_;

    load_module($test_module);

    my $meta = $self->get_test_metadata($test_module);
    $self->show_tests($meta);
}

sub _run_test_file {
    my ( $self, $test_file ) = @_;

    croak "unsupported (as of now)\n";
}

sub run {
    my ( $self, $test_file_or_module ) = @_;

    if($self->_is_module($test_file_or_module)) {
        $self->_run_test_module($test_file_or_module);
    } else {
        $self->_run_test_file($test_file_or_module);
    }
}

1;

__END__

# ABSTRACT:  A short description of Test::Class::Runner

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

=head1 SEE ALSO

=cut

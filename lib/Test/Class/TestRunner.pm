## no critic (RequireUseStrict)
package Test::Class::TestRunner;

## use critic (RequireUseStrict)
use strict;
use warnings;

use Test::Class::Runner::Util qw(load_module);

use namespace::clean;

sub new {
    my ( $class, $options ) = @_;

    return bless {
        %$options
    }, $class;
}

sub _create_runner {
    my ( $self ) = @_;

    my $runner_class = $self->{'runner_class'}
        || 'Test::Class::Runner::Console';

    my $runner_options = $self->{'runner_options'} || {};

    load_module($runner_class);

    return $runner_class->new($runner_options);
}

sub run {
    my ( $self, $test_file_or_module ) = @_;

    return $self->_create_runner->run($test_file_or_module);
}

1;

__END__

# ABSTRACT: Runs your Test::Class tests

=head1 SYNOPSIS

  use Test::Class::TestRunner;

  my $runner = Test::Class::TestRunner->new(\%options);
  $runner->run($test_file);
  # or #
  $runner->run($test_module);

=head1 DESCRIPTION

=head1 METHODS

=head2 Test::Class::TestRunner->new(\%options)

Creates a new L<Test::Class::TestRunner> object.

Valid options:

None yet.

=head2 $runner->run($test_file)

=head2 $runner->run($test_module)

Runs the test file C<$test_file> or test module C<$test_module>.  If
you provide a test file, it is assumed that you want to load that file
and run in the tests in the C<main> package.

=head1 SEE ALSO

L<run-test-class.pl>

=cut

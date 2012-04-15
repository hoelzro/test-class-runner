## no critic (RequireUseStrict)
package Test::Class::TestRunner;

## use critic (RequireUseStrict)
use strict;
use warnings;

use Test::Class::Runner::Console;

use namespace::clean;

sub new {
    my ( $class, $options ) = @_;

    return bless {
    }, $class;
}

sub _create_runner {
    my ( $self ) = @_;

    # XXX hardcoded and optionless for now
    return Test::Class::Runner::Console->new;
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

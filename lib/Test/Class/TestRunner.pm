## no critic (RequireUseStrict)
package Test::Class::TestRunner;

## use critic (RequireUseStrict)
use strict;
use warnings;

use Module::Find qw(usesub);

use Test::Class::Runner; # XXX we need to make sure it's loaded so
                         #     Test::Class works properly
use Test::Class::Runner::Util qw(load_module);

sub _role_count {
    my ( $plugin, $role_lookup ) = @_;

    return scalar(grep {
        $role_lookup->{$_}
    } $plugin->roles);
}

sub _match_plugins_to_roles {
    my ( $lhs, $rhs, $role_lookup ) = @_;

    my $n_lhs_matches = _role_count($lhs, $role_lookup);
    my $n_rhs_matches = _role_count($rhs, $role_lookup);

    my $cmp = $n_lhs_matches <=> $n_rhs_matches;

    return $cmp if $cmp;
    return $lhs->precedence <=> $rhs->precedence;
}

use namespace::clean;

sub new {
    my ( $class, $options ) = @_;

    return bless {
        %$options
    }, $class;
}

sub _get_runner_class_from_roles {
    my ( $self ) = @_;

    my $roles = $self->{'roles'};

    my %role_lookup = map { $_ => 1 } @$roles;

    my @plugins = usesub 'Test::Class::Runner';

    @plugins = grep {
        $_->isa('Test::Class::Runner') &&
        _role_count($_, \%role_lookup) > 0
    } @plugins;

    return unless @plugins;

    @plugins = reverse sort {
        _match_plugins_to_roles($a, $b, \%role_lookup)
    } @plugins;

    return $plugins[0];
}

sub create_runner {
    my ( $self ) = @_;

    my $runner_class;

    if($self->{'roles'}) {
        $runner_class = $self->_get_runner_class_from_roles;
        return unless $runner_class;
    } else {
        $runner_class = $self->{'runner_class'}
            || 'Console';

        $runner_class = 'Test::Class::Runner::' . $runner_class;
    }

    my $runner_options = $self->{'runner_options'} || {};

    load_module($runner_class);

    return $runner_class->new($runner_options);
}

sub run {
    my ( $self, $test_file_or_module ) = @_;

    return $self->create_runner->run($test_file_or_module);
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

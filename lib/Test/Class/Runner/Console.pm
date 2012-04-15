## no critic (RequireUseStrict)
package Test::Class::Runner::Console;

## use critic (RequireUseStrict)
use strict;
use warnings;
use parent 'Test::Class::Runner';

use List::Util qw(max);

use namespace::clean;

sub show_tests {
    my ( $self, $metadata ) = @_;

    my @classes = $metadata->test_classes;

    foreach my $class (@classes) {
        my @methods = $metadata->test_methods($class);

        my $max_method_length = max(map { length() } @methods);
        my $format            = '%-' . $max_method_length . 's - %s' . "\n";
        foreach my $method (sort @methods) {
            my $result = $self->run_test_method($class, $method);

            if($result->all_passed) {
                printf $format, $method, "\e[32;1mPASSED\e[0m";
            } else {
                printf $format, $method, "\e[31;1mFAILED\e[0m";
            }
        }
    }
}

1;

__END__

# ABSTRACT:

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

=cut

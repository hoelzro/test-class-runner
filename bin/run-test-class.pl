#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Test::Class::TestRunner;

sub usage {
    print <<"END_USAGE";
usage: $0 [test file or module]
END_USAGE

    exit 0;
}

sub help {
    exit 0;
}

sub version {
    print $Test::Class::TestRunner::VERSION, "\n";
    exit 0;
}

sub man {
    exit 0;
}

my %options;

my $ok = GetOptions(
    'version' => \&version,
    'usage'   => \&usage,
    'help'    => \&help,
    'man'     => \&man,
);

if(!$ok || !@ARGV) {
    usage();
}

my ( $file_or_module ) = @ARGV;

my $runner = Test::Class::TestRunner->new(\%options);

$runner->run($file_or_module);

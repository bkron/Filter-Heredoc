#!/usr/bin/perl

use strict;
use warnings;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Test confess() test if two ingress line is input after each other
use Filter::Heredoc qw ( hd_getstate hd_init );

use Test::More tests => 4;  # Note we should only run 4 successful tests
my %state;
my ( $state, $line );

# Set state to source, and flush all state arrays
hd_init();
eval {
    while (<DATA>) {
        next if /^\s+/ ; # prevents trailing empty __DATA__ cause split's undefs
        ( $state , $line ) = split /]/;
        %state = hd_getstate( $line );
        is( $state{statemarker}, $state, 'hd_getstate()');
    }
};


__DATA__
S]#!/usr/bin/perl
S]use warnings;
S]use strict;
I]my $string = <<_END_ONE ;
I]my $string = <<_END_TWO ; # 5th line cause an exception
H]Some text
H]Split into multiples lines
H]Is clearly defined
E]_END_OF_TEXT
S]print $string;

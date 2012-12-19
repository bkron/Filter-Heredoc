#!/usr/bin/perl

use strict;
use warnings;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Test confess() test if two egress line is input after each other
use Filter::Heredoc qw ( hd_getstate hd_init );

use Test::More tests => 6 ;  # Note we should only run 6 successful tests
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

# 7th line cause an excemption (two delimiters in a row at egress)

__DATA__
S]#!/usr/bin/perl
S]use warnings;
I]my $string = <<END ; <<END
H]Some text
H]Is clearly defined
E]END  
E]END              
S]print $string;
S]print "We never reach here";

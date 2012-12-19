#!/bin/perl

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here
use Filter::Heredoc qw ( hd_getstate hd_labels );

my ($line, $delimiter);
my $TRUE = 1;
my $FALSE = q{};
my $SPACE = q{ };
my $space_and_done = " done";

my %marker;
my %state;

# read out the default markers
%marker = hd_labels();

# Ingress line
%state = hd_getstate( 'cat<<END' );
is( $state{statemarker}, $marker{ingress} , '<<END: hd_getstate()');

# Heredoc line
%state = hd_getstate( 'Mail from sysadmin' );
is( $state{statemarker}, $marker{heredoc} , 'heredoc: hd_getstate()');

# Egress line
%state = hd_getstate( 'END' );
is( $state{statemarker}, $marker{egress} , 'END: hd_getstate()');

# This is valaidation of bugfix, to prevent croak (Egress -> Egress invalid state change)
 %state = hd_getstate( $SPACE . 'done' );
 is( $state{statemarker}, $marker{source}, 'source: hd_getstate()');
#
## The key test - comment above and un-commnet this
#$line = $space_and_done;
#is( _is_egress( $line ), $FALSE, 'space and done word only');

done_testing (4);
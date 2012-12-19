#!/usr/bin/perl

use strict;
use warnings;
use Test::More ;

# confess() test if line is 'undef'

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Note must eval "" and not eval {}
eval "use Test::Carp 0.2";
plan skip_all => 'Test::Carp 0.2 required' if $@; 

# Tests starts here

use Filter::Heredoc qw( hd_getstate hd_labels );
use Filter::Heredoc qw( @CARP_INGRESS );

my %marker;
my %state;
my $line ;

# read out the default markers
%marker = hd_labels();

# Third line (ingress) cause an invalid ingress->ingress change
%state = hd_getstate( 'echo "This a shell script"' );   # source line
is( $state{statemarker}, $marker{source}, 'source: hd_getstate()');

%state = hd_getstate( 'echo "cat << END"' );     # first ingress line
is( $state{statemarker}, $marker{ingress}, 'ingress: hd_getstate()');

my $reg = qr/$CARP_INGRESS[0]/;
$line = q{echo "cat << END"};
does_confess_that_matches( sub { hd_getstate ( $line) ; }, $reg ) ;

done_testing (3);

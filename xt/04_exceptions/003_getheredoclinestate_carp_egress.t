#!/usr/bin/perl

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Note must eval "" and not eval {}
eval "use Test::Carp 0.2";
plan skip_all => 'Test::Carp 0.2 required' if $@; 

# Tests starts here

use Filter::Heredoc qw( hd_getstate hd_labels );
use Filter::Heredoc qw( @CARP_EGRESS );

my %marker;
my %state;
my $line ;

# read out the default markers
%marker = hd_labels();

# Fifth line (egress) cause an invalid egress->egress change
%marker = hd_getstate( 'echo "This a shell script"' );  # source line
is( $state{statemarker}, $marker{source}, 'source: hd_getstate()');

%marker = hd_getstate( 'echo "cat << END;cat <<END"' ); # first ingress
is( $state{statemarker}, $marker{ingress}, 'ingress: hd_getstate()');

%marker = hd_getstate( 'Hello there there!' );            # heredoc
is( $state{statemarker}, $marker{heredoc}, 'heredoc: hd_getstate()');

%marker = hd_getstate( 'END' );                        # first egress
is( $state{statemarker}, $marker{egress}, 'egress: hd_getstate()');

$line = q{END};
my $reg = qr/$CARP_EGRESS[0]/;
does_confess_that_matches( sub { hd_getstate ( $line ) ; }, $reg ) ;

done_testing (5);

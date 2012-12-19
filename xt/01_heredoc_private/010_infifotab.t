#!perl -T

use strict;
use warnings;
use Test::More;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _infifotab );

my $nextoutflagvalue;
my $EMPTY_STR = q{};          # FALSE
my $COPYOUTFROMFIFO = 1;

_infifotab( 1 );                                      # insert tabremove = 1
_infifotab( 1 );                                      # insert tabremove = 1
is( _infifotab(), '1', 'get 1st tabremoval true');     # extract it first
is( _infifotab(), '1', 'get 2nd tabremoval true');     # extract it second
is( _infifotab(), $EMPTY_STR, 'get tabremoval empty'); # extract 2nd time


# Now with look ahead tests
_infifotab( $EMPTY_STR );                        # insert tabremoval = false
_infifotab( 1 );                                 # insert tabremove = 1

# Now the first q{} should be waiting to come out from fifo
$nextoutflagvalue = _infifotab( q{}, $COPYOUTFROMFIFO );
is( $nextoutflagvalue, q{}, 'copy out from tabfifo');
$nextoutflagvalue = _infifotab ();  
is( $nextoutflagvalue, q{}, 'get tabflag from tabfifo');

# Now the '1' sould be waiting
$nextoutflagvalue = _infifotab( q{}, $COPYOUTFROMFIFO );
is( $nextoutflagvalue,'1', 'copy out from tabfifo');
$nextoutflagvalue = _infifotab();  
is( $nextoutflagvalue, '1', 'get tabflag from tabfifo');

# Now tabfifo should be empty
$nextoutflagvalue = _infifotab( q{}, $COPYOUTFROMFIFO );
is( $nextoutflagvalue, q{}, 'copy out from tabfifo');
$nextoutflagvalue = _infifotab();  
is( $nextoutflagvalue, q{}, 'get tabflag from tabfifo');

done_testing (9);

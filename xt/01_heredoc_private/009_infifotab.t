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

my $EMPTY_STR = q{};

_infifotab( 1 );                                       # insert tabremove = 1
is( _infifotab(), '1', 'get tabremoval true');          # extract it
is( _infifotab(), $EMPTY_STR, 'get tabremoval empty');  # extract 2nd time

# set in two and retrieve them again in fifo order
_infifotab ($EMPTY_STR );                               # insert empty string
is( _infifotab(), $EMPTY_STR, 'get tabremoval empty');  # extract it

# with undef
_infifotab ( undef );                                   # insert undef
is( _infifotab(), $EMPTY_STR, 'get tabremoval undef');  # extract it

_infifotab( 1 );                                       # insert tabremove = 1
_infifotab( 1 );                                       # insert tabremove = 1
is( _infifotab(), '1', 'get 1st tabremoval true');      # extract it first
is( _infifotab(), '1', 'get 2nd tabremoval true');      # extract it second
is( _infifotab(), $EMPTY_STR, 'get tabremoval empty');  # extract 2nd time

done_testing (7);

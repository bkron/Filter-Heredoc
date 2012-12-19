#!perl -T

use strict;
use warnings;
use Test::More;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _is_comment );

my $emptystr = q{};
   
is( _is_comment('#'), 1, 'identified a comment');
   
is( _is_comment('   # line'), 1 , 'identified a comment');

is( _is_comment( ' print "#"  ' ), $emptystr,  'not a comment');

is( _is_comment( !defined ), $emptystr, 'not a comment - undef');

is( _is_comment(), $emptystr, 'not a comment - no arguments');

is( _is_comment( '0' ), $emptystr, 'not a comment was 0');

is( _is_comment( '1' ), $emptystr, 'not a comment was 1');

is( _is_comment( '-1' ), $emptystr, 'not a comment was (-1)');

is( _is_comment( $emptystr ), $emptystr, 'not a comment was empty string');

ok(  ! _is_comment () , 'not (!) operator applied infront of _is_comment()' );

done_testing (10);

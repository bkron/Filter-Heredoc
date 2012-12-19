#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc::Rule qw ( _is_lonely_redirect );

my $EMPTY_STR = q{};
my $line; 

$line = "cat <<";   
is( _is_lonely_redirect( $line ), 1 , 'lonely << ');

$line = "cat <<-";   
is( _is_lonely_redirect( $line ), 1 , 'lonely <<');
   
$line = "cat <<EOF ;";   
is( _is_lonely_redirect( $line ), $EMPTY_STR, 'not lonely');

$line = "cat <<-EOF ;";   
is( _is_lonely_redirect( $line ), $EMPTY_STR, 'not lonely');

is( _is_lonely_redirect( !defined ), $EMPTY_STR, 'undef');

is( _is_lonely_redirect(), $EMPTY_STR, 'no arguments');

is( _is_lonely_redirect( '0' ), $EMPTY_STR, 'argument was 0');

is( _is_lonely_redirect( '1' ), $EMPTY_STR, 'argument was 1');

is( _is_lonely_redirect( '-1' ), $EMPTY_STR, 'argument was (-1)');

is( _is_lonely_redirect( $EMPTY_STR ), $EMPTY_STR, 'argument was empty string');

ok(  ! _is_lonely_redirect () , 'not (!) operator applied infront of _is_lonely_redirect()' );

done_testing (11);

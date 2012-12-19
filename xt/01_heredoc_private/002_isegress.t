#!/usr/bin/perl

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _is_egress _infifo );

my ($line, $delimiter);
my $TRUE = 1;
my $FALSE = q{};

# test egress - first insert some delimiters
$delimiter = 'END_INFIRST';
_infifo( $delimiter );       # insert 1st delimiter
$delimiter = 'END_INSECOND';
_infifo( $delimiter );       # insert 2nd delimiter


$line = q(EOF);
is( _is_egress( $line ), $FALSE, 'simple delimiter');

$line = q(END);
is( _is_egress( $line ), $FALSE, 'partial word delimiter');

$line = q(INFIRST);
is( _is_egress( $line ), $FALSE, 'partial word delimiter');

$line = 'END_INSECOND END';
is( _is_egress( $line ), $FALSE, '2nd word delimiter');

$line = q(END_INFIRST);
is( _is_egress( $line ), $TRUE, 'real delimiter');

$line = 'END_INFIRST END_INSECOND';
is( _is_egress( $line ), $TRUE, '2nd word delimiter');  

$line = q(END_INSECOND);
is( _is_egress( $line ), $FALSE, 'second in array delimiter');

$line = 'END_INSECOND END_INFIRST';
is( _is_egress( $line ), $FALSE, '2nd word wrong order of delimiters');

done_testing (8);
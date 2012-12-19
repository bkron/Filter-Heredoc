#!perl -T

use strict;
use warnings;
use Test::More;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _is_ingress );

my $line;
my $TRUE = 1;
my $FALSE = q{};

# test ingress (<<)
$line = q(<<END);
is( _is_ingress( $line ), $TRUE, 'simple ingress');
$line = q( <<END);
is( _is_ingress( $line ), $TRUE, 'simple ingress with space');
$line = q(<<END);
is( _is_ingress( "\t" . $line ), $TRUE, 'simple ingress with tab');
$line = q( << END );
is( _is_ingress( "\t" . $line ), $TRUE, 'messy ingress, with tab');

# test with comment #
$line = q(#<<END);
is( _is_ingress( "\t" . $line ), $FALSE, 'ingress, but commented out');

$line = q(<<#END);
is( _is_ingress( "\t" . $line ), $TRUE, 'weired ingress, with comment char(#)');

done_testing (6);
#!perl -T

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _strip_tabdelimiter );

my $line;

$line = q{-END};
is( _strip_tabdelimiter( $line ), q{END}, 'one <<- delimiter');

$line = q{END};
is( _strip_tabdelimiter( $line ), q{END}, 'without <<- delimiter');

done_testing (2);

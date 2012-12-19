#!perl -T

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _strip_quotes );

my $line;

# strip q{"}
$line = qw("END");
is( _strip_quotes( $line ), q{END}, 'double quote'); 
$line = qw("E"ND");
is( _strip_quotes( $line ), q{END}, 'double quote'); 
$line = qw(""END);
is( _strip_quotes( $line ), q{END}, 'double quote'); 
$line = qw(END"");
is( _strip_quotes( $line ), q{END}, 'double quote'); 

# strip q{'}
$line = qw('END');
is( _strip_quotes( $line ), q{END}, 'single quote'); 
$line = qw('E'ND');
is( _strip_quotes( $line ), q{END}, 'single quote'); 
$line = qw(''END);
is( _strip_quotes( $line ), q{END}, 'single quote'); 
$line = qw(END'');
is( _strip_quotes( $line ), q{END}, 'single quote'); 

# strip q{\}
$line = qw(\END\\);
is( _strip_quotes( $line ), q{END}, 'escape quote'); 
$line = qw(\E\ND\\);
is( _strip_quotes( $line ), q{END}, 'escape quote'); 
$line = qw(\\END);
is( _strip_quotes( $line ), q{END}, 'escape quote'); 
$line = qw(END\\);
is( _strip_quotes( $line ), q{END}, 'escape quote');

# a very messy line
$line = qw(\""E'N"'"D'\\);
is( _strip_quotes( $line ), q{END}, 'mixed escapes, single, double quote');

done_testing (13);

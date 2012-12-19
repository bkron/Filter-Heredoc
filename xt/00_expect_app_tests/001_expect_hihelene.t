#!perl
use strict;
use warnings;
use Test::More;

#
# Tests only for filter-heredoc script (i.e App.pm)
#

unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}
eval  "use Test::Expect 0.31";
plan skip_all => 'Test::Expect 0.31 required' if $@; 

# Tests starts here (note the 'expect_run', counts as one test)
plan tests => 13;

expect_run(
    command => 'filter-heredoc -',
    prompt => '> ',
    quit => "\cD",
);
my $srcmatch = 'S';
my $ingmatch = 'I';
my $hdmatch = 'H';
my $egrmatch = 'E';

my $srcregex = qr/^$srcmatch/;
my $ingregex = qr/^$ingmatch/;
my $hdregex = qr/^$hdmatch/;
my $egrregex = qr/^$egrmatch/;

expect_send ( 'echo Hi', 'expect source send' );   
expect_like ( $srcregex, 'source line-by-line');

expect_send ( 'cat << END1;cat << END2', 'expect ingress send' );  
expect_like ( $ingregex, 'ingress line-by-line');

expect_send ( 'Hi,', 'expect heredoc send' );  
expect_like ( $hdregex, 'heredoc line-by-line');

expect_send ( 'END1', 'expect egress send' );
expect_like ( $egrregex, 'engress line-by-line');

expect_send ( 'Helene!', 'expect heredoc send' );  
expect_like ( $hdregex, 'heredoc line-by-line');

expect_send ( 'END2', 'expect egress send' );
expect_like ( $egrregex, 'engress line-by-line');



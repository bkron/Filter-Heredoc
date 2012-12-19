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
#plan tests => 5;

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

expect_send ( 'cat << END', 'expect ingress send' );  
expect_like ( $ingregex, '1st ingress line-by-line');

# This line Carp::confess
eval {
    expect_send ( 'cat << END', 'expect ingress send' );
};

# if exception have occured and error file have been written
# we are done. Remove them to next time.
my @error_files = <$ENV{HOME}/*.error>;
if ( @error_files ) {
    done_testing(5);
    unlink ( @error_files );
}



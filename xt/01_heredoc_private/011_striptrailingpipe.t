#!/usr/bin/perl

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _strip_trailing_pipe );

my $EMPTY_STR = q{};

my $line = q{cat << EOF|sed 's/b/k'};
is( _strip_trailing_pipe( $line ) , q{cat << EOF} , 'trailing pipe with cmd');

is( _strip_trailing_pipe( qq{cat << EOF\ |sed 's/b/k'} ) , qq{cat << EOF\ } , 'trailing pipe with cmd');
is( _strip_trailing_pipe( qq{cat << EOF| sed 's/b/k'} ) , q{cat << EOF} , 'trailing pipe with cmd');
is( _strip_trailing_pipe( qq{cat << EOF |\nsed 's/b/k'} ) , qq{cat << EOF } , 'trailing pipe with cmd');

is( _strip_trailing_pipe( q{cat << EOF|} ) , q{cat << EOF} , 'trailing pipe');
is( _strip_trailing_pipe( qq{cat << EOF |} ) , qq{cat << EOF } , 'trailing pipe');
is( _strip_trailing_pipe( qq{cat << EOF \t  |\nsed 's/b/k'} ) , qq{cat << EOF \t  } , 'trailing pipe');
is( _strip_trailing_pipe( qq{cat << EOF| \t} ) , q{cat << EOF} , 'trailing pipe');
is( _strip_trailing_pipe( qq{cat << EOF\t| \t} ) , qq{cat << EOF\t} , 'trailing pipe');

# some crazy tests

is( _strip_trailing_pipe( undef ), $EMPTY_STR, 'undef');

is( _strip_trailing_pipe( $EMPTY_STR ), $EMPTY_STR, 'argument was empty string');

done_testing (11);
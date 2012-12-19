#!perl -T

use strict;
use warnings;
use Test::More;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( _infifo );

my ( $delimiter, $nextoutdelimiter) ;
my $COPYOUTFROMFIFO = 1;
my $EMPTY_STR = q{};

$delimiter = 'END';
_infifo ( $delimiter );                   # insert delimiter
is( _infifo(), q{END}, 'get delimiter');  # extract delimiter

# extract delimiter when array empty - returns EMPTY_STR (q{})
is( _infifo(), $EMPTY_STR, 'get delimiter again');


# set in two and retrieve them again in fifo order
$delimiter = 'END_INFIRST';
_infifo ( $delimiter );       # insert 1st delimiter
$delimiter = 'END_INSECOND';
_infifo ( $delimiter );       # insert 2nd delimiter

is( _infifo(), q{END_INFIRST}, 'get 1st delimiter');   # extract 1st delimiter
is( _infifo(), q{END_INSECOND}, 'get 2nd delimiter');  # extract 2nd delimiter


# extract delimiter when array empty again - returns EMPTY_STR (q{})
is( _infifo(), $EMPTY_STR, 'empty delimiter array again');

##
## Now just copy out next element from fifo
## (without changing the terminator array)
##
# set in two new delimiters in the terminator array
$delimiter = 'END_INFIRST';
_infifo ( $delimiter );       # insert 1st delimiter
$delimiter = 'END_INSECOND';
_infifo ( $delimiter );       # insert 2nd delimiter

# Now looks what's waiting to come out from fifo
$nextoutdelimiter = _infifo ( q{}, $COPYOUTFROMFIFO );
is( $nextoutdelimiter, q{END_INFIRST}, 'copy out delimiter from fifo');
# Now really retrive both delimiters from the fifo 
is( _infifo(), q{END_INFIRST}, 'get 1st delimiter');  # extract 1st delimiter
is( _infifo(), q{END_INSECOND}, 'get 2nd delimiter');  # extract 2nd delimiter


# Now repeat this multiple times
$delimiter = 'EOF';
_infifo ( $delimiter );       # insert 1st delimiter
$nextoutdelimiter = _infifo ( q{}, $COPYOUTFROMFIFO );
is( $nextoutdelimiter, q{EOF}, '1st copy out delimiter from fifo');
$nextoutdelimiter = _infifo ( q{}, $COPYOUTFROMFIFO );
is( $nextoutdelimiter, q{EOF}, '2nd copy out delimiter from fifo');
$nextoutdelimiter = _infifo ( q{}, $COPYOUTFROMFIFO );
is( $nextoutdelimiter, q{EOF}, '3rd copy out delimiter from fifo');
# Now really retrive the delimiter from the fifo 
is( _infifo(), q{EOF}, 'get original delimiter'); 

# Test some weired conditions
# What happens if we forgot the to set first argument to the empty string
$delimiter = 'END_INFIRST';
_infifo ( $delimiter );       # insert 1st delimiter
$nextoutdelimiter = _infifo ( $COPYOUTFROMFIFO );     # Oops forgot the set empty string
                                                      # will return 'undef'
is( $nextoutdelimiter, undef, 'copy out delimiter returns undef from fifo with an unset empty string');
is( _infifo(), q{END_INFIRST}, 'get 1st delimiter');  # extract 1st delimiter

done_testing (14);

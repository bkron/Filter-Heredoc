#!perl -T

use strict;
use warnings;
use Test::More ;

# Skip if not defined release testing by the author 
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => 'Author tests not required for installation');
}

# Tests start here

use Filter::Heredoc qw ( hd_labels _state );

my %marker;

# read out the default markers
%marker = hd_labels();

_state( $marker{source} );             # set source
is( _state(), q{S}, 'source marker');  # get source

_state( $marker{ingress} );             # set ingress
is( _state(), q{I}, 'ingress marker');  # get ingress

_state( $marker{heredoc} );             # set heredoc
is( _state(), q{H}, 'herdoc marker');  # get heredoc

_state( $marker{egress} );             # set egress
is( _state(), q{E}, 'egress marker');  # get egress

_state( $marker{heredoc} );             # set heredoc
is( _state(), q{H}, 'herdoc marker');  # get heredoc

_state( $marker{ingress} );             # set ingress
is( _state(), q{I}, 'ingress marker');  # get ingress

_state( $marker{source} );             # set source
is( _state(), q{S}, 'source marker');  # get source

done_testing (7);

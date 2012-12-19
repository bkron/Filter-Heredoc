#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

use Test::More tests => 9;
use Filter::Heredoc qw ( hd_getstate ); 

my %state;
my ( $state, $line, $match );

my @matchlist = ( 'EOF1', 'EOF2', 'EOF2', 'EOF1', 'EOF1', 'EOF3', 'EOF3', 'EOF3', 'EOF2');

# Simple test match heredoc lines on blockdelimiter (the delimiter in play that wraps the heredoc content)

my $cnt = 0;
while (<DATA>) {
    next if /^\s+/ ; # prevents trailing empty __DATA__ cause split's undefs
    ( $state , $line ) = split /]/;
    %state = hd_getstate( $line );
    if ( $state{statemarker} eq 'H' ) {
        is( $state{blockdelimiter}, $matchlist[$cnt], 'hd_getstate()');
        $cnt++;
    }
}


__DATA__
S]#!/bin/bash
S]echo "Test matching specific delimiters"
I]cat << EOF1
H]Match EOF1 delimiter 1-line1
E]EOF1
S]echo "-----------------"
I]cat << EOF2
H]Match EOF2 delimiter 2-line1
H]Match EOF2 delimiter 2-line2
E]EOF2
S]echo "----------------"
I]cat << EOF1
H]Match EOF1 delimiter 1-line1
H]Match EOF1 delimiter 1-line2
E]EOF1
S]echo "-----------------" 
I]cat << EOF3
H]Match EOF3 delimiter 3-line1
H]Match EOF3 delimiter 3-line2
H]Match EOF3 delimiter 3-line3
E]EOF3
S]echo "-----------------" 
I]cat << EOF2
H]Match EOF2 delimiter 2-line1
E]EOF2
S]echo "-----------------"
S]echo "All done"

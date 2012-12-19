#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

## Skip if not Author tests (RELEASE_TESTING) is defined
unless ( $ENV{RELEASE_TESTING} ) {
    plan( skip_all => q{Author tests not required for installation} );    
}

# Ensure a recent/stable version (=Debian squeeze) of Test::Spelling
my $min_ts = 0.11;  
eval "use Test::Spelling $min_ts";
plan skip_all => "Test::Spelling $min_ts required for POD spelling"
    if $@;

# Tests start here
my $spellchecker = q{aspell list -l en};
set_spell_cmd($spellchecker);
add_stopwords( <DATA> );
all_pod_files_spelling_ok();

__DATA__
Bertil
Kronlund
Ivkovic
heredoc
Ctrl-D
POSIX
perl
aspell
hunspell
ispell
podspell
MERCHANTIBILITY
ACKNOWLEDGEMENTS
API
MANPATH
redirections
redirector
IEEE
MSWin
pdf
html
TODO
ChangeLog
diskusage

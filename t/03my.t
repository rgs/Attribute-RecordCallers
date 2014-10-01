#!perl

BEGIN {
    if ($] < 5.018) {
        print "1..0 # SKIP: needs 5.18 or later\n";
        exit 0;
    }
}

use 5.18.0;
use warnings;
use Test::More tests => 2;
use feature 'lexical_subs';
no warnings "experimental::lexical_subs";
use Attribute::RecordCallers;

my $calls = 0;
my sub foo :RecordCallers { $calls++ }

foo();
is($calls, 1, 'the lexical sub has been called');

TODO: {
    local $TODO = 'TBI';
    (my $k) = keys %Attribute::RecordCallers::callers;
    is($k, 'main::ANON', 'the call to the lexical sub has been recorded');
}

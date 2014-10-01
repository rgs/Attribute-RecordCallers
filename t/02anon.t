#!perl

use strict;
use warnings;
use Test::More tests => 2;
use Attribute::RecordCallers;

package T;

my $calls = 0;
my $closure = sub :RecordCallers { $calls++ };

$closure->();
::is($calls, 1, 'the closure has been called');

TODO: {
    local our $TODO = 'TBI';
    (my $k) = keys %Attribute::RecordCallers::callers;
    ::is($k, 'T::ANON', 'the call to the closure has been recorded');
}

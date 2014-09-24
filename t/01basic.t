#!perl

use Test::More tests => 13;

BEGIN { use_ok 'Attribute::RecordCallers' }

my $manual_counter = 0;

sub call_me_maybe : RecordCallers {
    $manual_counter++;
}

ok(!exists $Attribute::RecordCallers::callers{'main::call_me_maybe'}, 'no caller yet');

call_me_maybe(); my $expected_line = 15;
call_me_maybe();

is($manual_counter, 2, 'called twice, manual check');
ok(exists $Attribute::RecordCallers::callers{'main::call_me_maybe'}, 'seen a caller');
is(scalar @{$Attribute::RecordCallers::callers{'main::call_me_maybe'}}, 2, 'seen exactly 2 calls');
for my $c (@{$Attribute::RecordCallers::callers{'main::call_me_maybe'}}) {
    is($c->[0], 'main', 'caller package is main');
    like($c->[1], qr/01basic\.t$/, 'file name is correct');
    is($c->[2], $expected_line, 'line number is correct');
    ok($c->[3] - time < 10, 'time is correct');
    $expected_line++;
}

package Attribute::RecordCallers;

use strict;
use warnings;
use Attribute::Handlers;
use Time::HiRes qw(time);

our $VERSION = '0.01';
our %callers;

sub UNIVERSAL::RecordCallers :ATTR(CODE) {
    my ($pkg, $glob, $referent) = @_;
    no strict 'refs';
    no warnings 'redefine';
    my $subname = $pkg . '::' . *{$glob}{NAME};
    *$subname = sub {
        push @{ $callers{$subname} ||= [] }, [ caller, time ];
        goto &$referent;
    };
}

sub clear {
    %callers = ();
}

1;

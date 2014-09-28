package Attribute::RecordCallers;

use strict;
use warnings;
use Attribute::Handlers;
use Time::HiRes qw(time);

our $VERSION = '0.01';
our %callers;

sub UNIVERSAL::RecordCallers :ATTR(CODE,BEGIN) {
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

=head1 NAME

Attribute::RecordCallers - keep a record of who called a subroutine

=head1 SYNOPSIS

    use Attribute::RecordCallers;
    sub call_me_and_i_ll_tell_you : RecordCallers { ... }

=head1 DESCRIPTION

=head1 LICENSE

(c) Rafael Garcia-Suarez (rgs at consttype dot org) 2014

This program is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

A git repository for the sources is at L<https://github.com/rgs/Attribute-RecordCallers>.

=cut

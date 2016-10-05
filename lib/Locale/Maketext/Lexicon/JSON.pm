package Locale::Maketext::Lexicon::JSON;
use strict;
use warnings;

use Carp ();
use JSON::XS qw(decode_json);

sub parse {
    my $self = shift;

    Carp::cluck "Undefined source called\n" unless defined $_[0];

    +{ map { %{ decode_json($_) } } @_ };
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Locale::Maketext::Lexicon::JSON - JSON parser for Maketext

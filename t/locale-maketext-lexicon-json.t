package Test::Locale::Maketext::Lexicon::JSON;
use parent qw(Locale::Maketext);
use Locale::Maketext::Lexicon ();

sub import {
    my $class = shift;

    my %locales = map { $_ => [ JSON => "t/data/$_.json", ], } qw( en_US ja_JP);
    Locale::Maketext::Lexicon->import(
        {   %locales,
            _decode  => 1,
            _preload => 1,
        }
    );
}

package main;
use strict;
use warnings;

use Test::More;
use Data::Section::Simple qw(get_data_section);

my $class = 'Locale::Maketext::Lexicon::JSON';
use_ok $class;

subtest parse => sub {
    use utf8;

    is_deeply $class->parse(values %{&get_data_section}),
        {
        foo  => 'bar',
        hoge => 'fuga',
        utf8 => 'ＵＴＦ−８の文字列',
        };
};

subtest 'get_handle for locales' => sub {
    Test::Locale::Maketext::Lexicon::JSON->import;

    subtest en_US => sub {
        my $i18n = Test::Locale::Maketext::Lexicon::JSON->get_handle('en_US');

        isa_ok $i18n, 'Test::Locale::Maketext::Lexicon::JSON::en_us';
        is $i18n->maketext('hello-world'), 'Hello! World!';
    };
    subtest ja_JP => sub {
        use utf8;

        my $i18n = Test::Locale::Maketext::Lexicon::JSON->get_handle('ja_JP');

        isa_ok $i18n, 'Test::Locale::Maketext::Lexicon::JSON::ja_jp';
        is $i18n->maketext('hello-world'), 'こんにちは！世界！';
    };
};

done_testing;

__DATA__

@@ json1

{"foo":"bar"}

@@ json2

{"hoge":"fuga"}

@@ json3

{"utf8":"ＵＴＦ−８の文字列"}

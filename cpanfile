requires 'JSON::XS';
requires 'Locale::Maketext::Lexicon';

on 'test' => sub {
    requires 'Data::Section::Simple';
    requires 'Test::More', '0.98';
};


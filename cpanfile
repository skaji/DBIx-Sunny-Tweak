requires 'perl', '5.008001';
requires 'DBIx::Sunny';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'DBD::SQLite';
};


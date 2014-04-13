use strict;
use warnings FATAL => 'all';
use utf8;
use Test::More;

use DBIx::Sunny::Tweak;

my $dbh = DBIx::Sunny->connect("dbi:SQLite:dbname=", "", "");
$dbh->do("CREATE TABLE test (id INT, name TEXT)");
$dbh->do("INSERT INTO test (id, name) VALUES (10, 'foo')");
$dbh->do("INSERT INTO test (id, name) VALUES (11, 'bar')");
$dbh->do("INSERT INTO test (id, name) VALUES (12, 'baz')");

my $query = q|SELECT id, name FROM test WHERE id < ? ORDER BY id|;

subtest row => sub {
    my $row  = $dbh->select_row_arrayref($query, 11);
    is_deeply $row, [10, 'foo'];
};
subtest all => sub {
    my $rows = $dbh->select_all_arrayref($query, 12);
    is_deeply $rows, [[10, 'foo'], [11, 'bar']];
};
subtest sth_array => sub {
    my $sth = $dbh->select_sth($query, 100);
    is_deeply $sth->fetchrow_arrayref, [10, 'foo'];
    is_deeply $sth->fetchrow_arrayref, [11, 'bar'];
    is_deeply $sth->fetchrow_arrayref, [12, 'baz'];
    ok !$sth->fetchrow_arrayref;
};
subtest sth_hash => sub {
    my $sth = $dbh->select_sth($query, 100);
    is_deeply $sth->fetchrow_hashref, {id => 10, name => 'foo'};
    is_deeply $sth->fetchrow_hashref, {id => 11, name => 'bar'};
    is_deeply $sth->fetchrow_hashref, {id => 12, name => 'baz'};
    ok !$sth->fetchrow_hashref;
};

done_testing;

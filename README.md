# NAME

DBIx::Sunny::Tweak - add some methods to DBIx::Sunny

# SYNOPSIS

    use DBIx::Sunny::Tweak;

    my $dbh = DBIx::Sunny->connect($dsn, $user, $pass);

    my $row  = $dbh->select_row_arrayref($query, @bind);
    my $rows = $dbh->select_all_arrayref($query, @bind);
    my $sth  = $dbh->select_sth($query, @bind);

# DESCRIPTION

DBIx::Sunny::Tweak adds some methods to DBIx::Sunny.
DBIx::Sunny is simple and awesome,
but sometimes I want to get table rows as
array references not hash references,
and statement handlers for iteration.

# METHODS

- `select_row_arrayref`, `select_all_arrayref`

    Just like `select_row`, `select_all` but return arrayrefs, not hashrefs.

- `select_sth`

    Get statement handler.

# SEE ALSO

[DBIx::Sunny](https://metacpan.org/pod/DBIx::Sunny)

[DBI](https://metacpan.org/pod/DBI)

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

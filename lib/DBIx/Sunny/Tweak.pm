package DBIx::Sunny::Tweak;
use strict;
use warnings;

our $VERSION = "0.01";
use DBIx::Sunny;

{
    package
        DBIx::Sunny::db;
    use strict;
    use warnings;
    sub select_row_arrayref {
        my $self = shift;
        my ($query, @bind) = $self->fill_arrayref(@_);
        my $row = $self->selectrow_arrayref($query, {}, @bind);
        return unless $row;
        return $row;
    }
    sub select_all_arrayref {
        my $self = shift;
        my ($query, @bind) = $self->fill_arrayref(@_);
        my $rows = $self->selectall_arrayref($query, {}, @bind);
        return $rows;
    }
    sub select_sth {
        my $self = shift;
        my ($query, @bind) = $self->fill_arrayref(@_);
        my $sth = $self->prepare($query);
        $sth->execute(@bind);
        $sth;
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

DBIx::Sunny::Tweak - add some methods to DBIx::Sunny

=head1 SYNOPSIS

    use DBIx::Sunny::Tweak;

    my $dbh = DBIx::Sunny->connect($dsn, $user, $pass);

    my $row  = $dbh->select_row_arrayref($query, @bind);
    my $rows = $dbh->select_all_arrayref($query, @bind);
    my $sth  = $dbh->select_sth($query, @bind);

=head1 DESCRIPTION

DBIx::Sunny::Tweak adds some methods to DBIx::Sunny.
DBIx::Sunny is simple and awesome,
but sometimes I want to get table rows as
array references not hash references,
and statement handlers for iteration.

=head1 METHODS

=over 4

=item C<select_row_arrayref>, C<select_all_arrayref>

Just like C<select_row>, C<select_all> but return arrayrefs, not hashrefs.

=item C<select_sth>

Get statement handler.

=back

=head1 SEE ALSO

L<DBIx::Sunny>

L<DBI>

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut


use strict;
package Parse::CVSEntries;
our $VERSION = '0.01';

=head1 NAME

Parse::CVSEntries - parse a CVS/Entries file

=head1 SYNOPSIS

 my $parsed = Parse::CVSEntries->new( 'CVS/Entries' );
 for my $entry ($parsed->entries) {
     print $entry->name, " ", $entry->version, "\n";
 }

=head1 DESCRIPTION

=cut

=head1 METHODS

=head2 new( $file )

Opens a file and parses it invoking C<< entry_class->new >> to
actually prepare the data.

=cut

sub new {
    my $class    = shift;
    my $filename = shift;
    open my $fh, "<$filename" or return;
    my @entries = map { chomp; $class->entry_class->new($_) } <$fh>;
    bless \@entries, $class;
}

=head2 entries

Returns a list of all the entries in the parsed file.

=cut

sub entries {
    @{ $_[0] }
}

=head2 entry_class

What class to instantiate for each entry.  Defaults to C<Parse::CVSEntry>

=cut

sub entry_class {
    'Parse::CVSEntry';
}

=head1 Parse::CVSEntry

A representation of an entry in the entries file.

=head2 dir

=head2 name

=head2 version

=head2 modified

=cut

package Parse::CVSEntry;
use base 'Class::Accessor::Fast';
use Date::Parse qw( str2time );

# the actual fields in the file
my @fields = qw( dir name version modified bar baz );
__PACKAGE__->mk_accessors( @fields );

sub new {
    my $class = shift;
    my $line  = shift;

    my %self;
    @self{ @fields } = split /\//, $_;
    $class->SUPER::new(\%self);
}

1;
__END__


=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 COPYRIGHT

Copyright (C) 2003 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<File::Find::Rule::CVS>, cvs(1)

=cut

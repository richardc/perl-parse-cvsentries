use strict;
package Parse::CVSEntries;
use Parse::CVSEntry;

=head1 NAME

Parse::CVSEntries - parse a CVS/Entries file

=head1 SYNOPSIS

 my $parsed = Parse::CVSEntries->new( 'CVS/Entries' );
 for my $entry ($parsed->entries) {
     print $entry->name, " ", $entry->version, "\n";
 }

=cut

sub new {
    my $class    = shift;
    my $filename = shift;
    open my $fh, "<$filename" or return;
    my @entries = map { chomp; $class->entry_class->new($_) } <$fh>;
    bless \@entries, $class;
}

sub entries {
    @{ shift() }
}

sub entry_class {
    'Parse::CVSEntry';
}

1;
__END__

use strict;
package Parse::CVSEntries;

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
    my @entries = map { chomp; Parse::CVSEntry->new($_) } <$fh>;
    bless \@entries, $class;
}

sub entries {
    @{ shift() }
}

package Parse::CVSEntry;
use Class::Accessor::Fast;
use base 'Class::Accessor::Fast';
use Date::Parse qw( str2time );

# the actual fields in the file
my @fields = qw( dir name version modified bar baz );
__PACKAGE__->mk_accessors( @fields, 'mtime' );

sub new {
    my $class = shift;
    my $line  = shift;

    my %self;
    @self{ @fields } = split /\//, $_;
    $self{mtime} = str2time $self{modified}, "UTC"
      unless $self{dir};

    $class->SUPER::new(\%self);
}

1;
__END__

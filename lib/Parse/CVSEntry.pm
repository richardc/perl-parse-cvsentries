use strict;
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

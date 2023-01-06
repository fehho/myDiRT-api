package MyDirt::Controller::Doc;
use Mojo::Base "Mojolicious::Controller";
use DBI;
use MyDirt::Schema;
use feature qw(postderef);

=head1 Doc.pm - Controller for documents
Anything which is or of a document.

=cut

my $config = $MyDirt::config;

my $orm = MyDirt::Schema->connect(
    $config->{mssql}->{dbstring}, $config->{mssql}->{username},
    $config->{mssql}->{password}, { RaiseError => 1, LongReadLen => 4294967295 }
);

my $cache = $MyDirt::cache;

=head2 getTypeList
Public enpoint serving metadata of all document templates.
=cut

sub getTypeList {
    my $self = shift;
    my @all = $orm->resultset('TblDocType')->search( undef, {
	columns  => [qw/ doctypeid doctypename /]
    });
    my @forms;
    push @forms, { docID => $_->doctypeid, docName => $_->doctypename } for @all;

    $self->render( openapi => \@forms );
}

=head2 getTemplate
Public enpoint serving application/pdf of a document by ID.
=cut

sub getTemplate {
    my $self = shift;

    my $id = $self->param('docid');
    my $doc = $orm->resultset('TblDocType')->find( $id );

    $self->render( data => $doc->doctemplate, format => 'pdf' );
}
1;

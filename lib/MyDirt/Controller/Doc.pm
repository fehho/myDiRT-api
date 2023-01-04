package MyDirt::Controller::Doc;
use Mojo::Base "Mojolicious::Controller";
use DBI;
use MyDirt::Schema;
use feature qw(postderef);

my $config = $MyDirt::config;

my $orm = MyDirt::Schema->connect(
    $config->{mssql}->{dbstring}, $config->{mssql}->{username},
    $config->{mssql}->{password}, { RaiseError => 1, LongReadLen => 4294967295 }
);

my $cache = $MyDirt::cache;

sub getTypeList {
    my $self = shift->openapi->valid_input or return;

    my @all = $orm->resultset('TblDocType')->search( undef, {
	columns  => [qw/ doctypeid doctypename /]
    });
    my @forms;
    push @forms, { docID => $_->doctypeid, docName => $_->doctypename } for @all;

    $self->render( openapi => \@forms );
}

sub getTemplate {
    my $self = shift->openapi->valid_input or return;

    my $id = $self->param('docid');
    my $doc = $orm->resultset('TblDocType')->find( $id );

    $self->render( data => $doc->doctemplate, format => 'pdf' );
}
1;

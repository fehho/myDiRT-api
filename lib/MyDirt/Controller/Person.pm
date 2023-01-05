package MyDirt::Controller::Person;
use Mojo::Base "Mojolicious::Controller";
use Crypt::Passphrase;
use Crypt::Passphrase::Argon2;
use Session::Token;
use DBI;
use MyDirt::Schema;
use feature qw(postderef);
=head1 Person.pm - Controller for actions about a person and their data
Anything that is about individual, plus any persons above and below, go here.

=cut

my $auth = Crypt::Passphrase->new(
    encoder => Crypt::Passphrase::Argon2->new(
        time_cost => 1
    )
);

my $config = $MyDirt::config;

my $orm = MyDirt::Schema->connect(
    $config->{mssql}->{dbstring}, $config->{mssql}->{username},
    $config->{mssql}->{password}, { RaiseError => 1, LongReadLen => 4294967295 }
    #this is to allow getting user documents in getInfo
    #getInfo doesn't actually need user documents, and they are large files, it would be better to just not get them
);

my $tokens = Session::Token->new();

my $blank = $auth->hash_password(''); #for anti-timing attack

my $cache = $MyDirt::cache;

sub login {

=head2 login
Checks that credentials contained inside of body params belong to a user, and if so, give an authentication token. Gives 401 and a generic failed login error if there are either no credentials or wrong credentials.
=cut

    my $self = shift->openapi->valid_input or return;

    my $response = {};
    my $status   = 200;
    my $username = $self->param('user');
    my $user = $orm->resultset('TblLogin')->find({userloginid => $username});
    my $hash = $user->userpassword;
    if ( $auth->verify_password( $self->param('pass'), $hash ) ) {
        $status = 200;
        my $unique;
        until ($unique) {
            my $token = $tokens->get;

          # uncoverable branch false this should never happen on a single thread
            $unique = $token and next unless $cache->get($token);
            $tokens = Session::Token->new;

            # reseed this worker's generator
            # all workers will likely start with the same seed upon spawning
        }
        $response->{token} = $unique;
        $cache->set( $response->{token}, $user->userid->userid );
	$response->{debug} = $user->userid->userid;
    }
    else {
        $status = 418;
        $response->{reason} = "being cringe";
    }

    $self->render( openapi => $response, status => $status );
}

sub check {

=head2 check
Takes a token and returns at what unix timestamp it will expire at.
=cut

    my $self      = shift;
    my $errorCode = 0;
    $self->render( openapi =>
          { 'expires_at' => $cache->get_expires_at( $self->param('token') ) } );
}

sub info {

=head2 info
Takes a token and returns some information about the user that token belongs to, as well as the same information for subordinates.
=cut

    my $self     = shift;
    my $userData = {};
    my $status   = 200;
    my $user     = $orm->resultset('TblUser')->find( $cache->get( $self->param('token') ) );
    $userData->{name} =
      [ $user->userfirstname, $user->usermiddlename, $user->userlastname ];
    $userData->{rank}         = $user->rankid->ranktype;
    $userData->{documents}    = [];
    $userData->{org} = $user->organizationid->orgname;
    for my $doc ( $user->tbl_xref_user_docs ) {
        $doc = $doc->docid;
        my $docMeta = {
            Type  => $doc->doctypeid->doctypename,
	    Date  => 1672781365,
	    Unit  => $userData->{org},
	    Where => $doc->docwhere,
	    docid => $doc->docid
	};
        push $userData->{documents}->@*, $docMeta;
    }
    $userData->{subordinates} = {};
    my $supervisor = $user->tbl_user_subordinates_subordinateids->first;
    if( $supervisor ){
        $userData->{supervisor} =
	    $supervisor->userid->rankid->ranktype.
	    " ".
            $supervisor->userid->userlastname
    } else {
	$userData->{supervisor} = 'No supervisor';
    }
    for ( $user->tbl_user_subordinates_userids->all ) {
        my $airman = $_->subordinateid;
        $userData->{subordinates}->{ $airman->userid } = {
            name => [
                $airman->userfirstname, $airman->usermiddlename,
                $airman->userlastname
	    ],
	    rank => $airman->rankid->ranktype
        };
    }
    $self->render( status => $status, openapi => $userData );
}

sub infoOfSubordinate {
    my $self        = shift->openapi->valid_input or return;
    my $airman      = $orm->resultset('TblUser')->find( $self->param('key') );
    my $callingUser = $cache->get( $self->param('token') );
    my $status;
    my $response;
    if (
        $airman
        and $airman->tbl_user_subordinates_subordinateids->search(
            { userid => $callingUser }
        )
      )
    {
        $response = {
            name => [
                $airman->userfirstname, $airman->usermiddlename,
                $airman->userlastname
            ]
        };
        $status = 200;
    }
    else {
        $response = { reason =>
              'Supplied key does not belong to one of your subordinates' };
        $status = 418;
    }
    $self->render( status => $status, openapi => $response );
}

1;

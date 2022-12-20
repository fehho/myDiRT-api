package MyApp::Controller::Person;
use Mojo::Base "Mojolicious::Controller";
use Crypt::Passphrase;
use Crypt::Passphrase::Argon2;
use Session::Token;
use DBI;
use MyDirt::Schema;

=head1 Person.pm - Controller for actions about a person and their data
Anything that is about individual, plus any persons above and below, go here.

=cut

my $auth = Crypt::Passphrase->new(
    encoder => Crypt::Passphrase::Argon2->new(
        time_cost => 1
    )
);

my $config = $MyApp::config;

my $orm = MyDirt::Schema->connect(
        $config->{mssql}->{dbstring},
        $config->{mssql}->{username},
        $config->{mssql}->{password},
        { RaiseError => 1 }
);

my $tokens = Session::Token->new();

my $static = $auth->hash_password("baba booey");

my $cache = $MyApp::cache;

sub login {

=head2 login
Checks that credentials contained inside of body params belong to a user, and if so, give an authentication token. Gives 401 and a generic failed login error if there are either no credentials or wrong credentials.
=cut

  my $self = shift->openapi->valid_input or return;

  my $response = {};
  my $status = 200;
  if( $auth->verify_password( $self->param('pass'), $static ) ){
    $status = 200;
    my $unique;
    until($unique){
      my $token = $tokens->get;
      # uncoverable branch false this should never happen on a single thread
      $unique = $token and next unless $cache->get($token);
      $tokens = Session::Token->new;
      # reseed this worker's generator
      # all workers will likely start with the same seed upon spawning
    }
    $response->{token} = $unique;
    $cache->set($response->{token}, 2);
  } else {
      $status = 418;
      $response->{reason} = "being cringe";
  }
  
  $self->render(openapi => $response, status => $status);
}

sub check {

=head2 check
Takes a token and returns at what unix timestamp it will expire at.
=cut
    
    my $self = shift;
    my $errorCode = 0;
    $self->render(openapi => { 'expires_at' =>
	$cache->get_expires_at($self->param('token'))
    });
}

sub info {

=head2 info
Takes a token and returns some information about the user that token belongs to, as well as the same information for subordinates.
=cut
    
    my $self = shift;
    my $userData = {};
    my $status = 200;
    my $user = $orm->resultset('TblUser')->find(2);
    $userData->{name}         = [
				 $user->userfirstname,
				 $user->usermiddlename,
				 $user->userlastname
				];
    $userData->{rank}         = $user->rankid->ranktype;
    $userData->{documents}    = $user->tbl_xref_user_docs->count;
    $userData->{subordinates} = {};
    for($user->tbl_xref_user_subordinates->all){
	my $airman = $_->subordinateid;
	$userData->{subordinates}->{$airman->subordinateid} = {
	    name => [
		$airman->subfirstname,
		$airman->submiddlename,
		$airman->sublastname
	    ]
	};
    }
    $self->render(status => $status, openapi => $userData);
}
    
sub infoOfSubordinate {
    my $self = shift->openapi->valid_input or return;
    my $airman = $orm->resultset('TblSubordinate')
	->find( $self->param('key') );
    my $callingUser = $cache->get($self->param('token'));
    my $status;
    my $response;
    if( $airman and $airman->tbl_xref_user_subordinates
	->search({ userid => $callingUser }) ){
	$response = {
	    name => [
		$airman->subfirstname,
		$airman->submiddlename,
		$airman->sublastname
	    ]
	};
	$status = 200;
    } else {
	$response = { reason => 'Supplied key does not belong to one of your subordinates' };
	$status = 418;
    }
    $self->render(status => $status, openapi => $response);
}

1;

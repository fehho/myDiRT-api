package MyApp::Controller::Person;
use Mojo::Base "Mojolicious::Controller";
use Crypt::Passphrase;
use Crypt::Passphrase::Argon2;
use Session::Token;
use DBI;

#use Data::Serializer;         # needed for storing non-scalars in CHI 
#use Data::Serializer::Serial;

my $auth = Crypt::Passphrase->new(
    encoder => Crypt::Passphrase::Argon2->new(
        time_cost => 1
    )
);

my $tokens = Session::Token->new();

my $static = $auth->hash_password("baba booey");

my $cache = $MyApp::cache;

sub login {
  # Validate input request or return an error document
  my $self = shift->openapi->valid_input or return;

  my $response = {};
  my $status = 200;
  if( $auth->verify_password( $self->param('pass') || '', $static ) ){
    $status = 200;
    my $unique;
    until($unique){
      my $token = $tokens->get;
      $unique = $token and next unless $cache->get($token);
      $tokens = Session::Token->new;
      # reseed this worker's generator
      # all workers will likely start with the same seed upon spawning
    }
    $response->{token} = $unique;
    $cache->set($response->{token}, 1);
  } else {
      $status = 418;
      $response->{reason} = "being cringe";
  }
  
  $self->render(openapi => $response, status => $status);
}

sub checkTokenState {
    use Data::Dumper;
    print Dumper $cache;
    my $self = shift;
    my $errorCode = 0;
    $errorCode += 1 unless $cache->get( $self->param('token') );
    return $errorCode;
}

sub check {
    my $self = shift;
    my $errorCode = checkTokenState($self);
    $self->render(openapi => {fail => $errorCode});
}

sub info {
    my $self = shift;
    my $userData = {};
    my $status = 200;
    unless(checkTokenState($self) ){
	$userData->{name}         = ["Steve", '', "Jobs"];
	$userData->{rank}         = 'O1';
	$userData->{documents}    = 420;
	$userData->{subordinates} = {
	    deadbeef => {
		access    => 1,
		name      => ["Steve", "", "Wozniak"],
		rank      => "E10",
		documents => 0
	    }
	};
    } else {
	$status = 418;
	$userData->{reason} = "being named el bozo";
    }
    $self->render(status => $status, openapi => $userData);
}
    
	
1;

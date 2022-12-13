package MyApp::Controller::Auth;
use Mojo::Base "Mojolicious::Controller";

use Crypt::Passphrase;
use Crypt::Passphrase::Argon2;
use Session::Token;
use CHI;
#use Data::Serializer;         # needed for storing non-scalars in CHI 
#use Data::Serializer::Serial;

my $auth = Crypt::Passphrase->new(
    encoder => Crypt::Passphrase::Argon2->new(
        time_cost => 1
    )
);

my $tokens = Session::Token->new();

my $cache = CHI->new(
    driver => 'Memory',
    global => 1,
    expires_in => 3600
);

my $static = $auth->hash_password("baba booey");

sub login {
  # Validate input request or return an error document
  my $self = shift->openapi->valid_input or return;

  my $response = {};
  my $status = 200;
  if( $auth->verify_password( $self->param('pass') || '', $static ) ){
      $status = 200;
      $response->{token} = $tokens->get;
      $cache->set($response->{token}, 1);
  } else {
      $status = 418;
      $response->{reason} = "being cringe";
  }
  
  $self->render(openapi => $response, status => $status);
}

sub check {
  my $self = shift;
  my $errorCode = 0;
  $errorCode += 1 unless $cache->get( $self->param('token') );
  $self->render(openapi => {fail => $errorCode});
}

1;
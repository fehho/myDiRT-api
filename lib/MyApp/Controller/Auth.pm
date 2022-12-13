package MyApp::Controller::Auth;
use Mojo::Base "Mojolicious::Controller";

use Crypt::Passphrase;
use Crypt::Passphrase::Argon2;
use Session::Token;

my $auth = Crypt::Passphrase->new(
    encoder => Crypt::Passphrase::Argon2->new(
        time_cost => 1
    )
);

my $tokens = Session::Token->new();

my $static = $auth->hash_password("baba booey");

sub login {
  # Validate input request or return an error document
  my $self = shift->openapi->valid_input or return;

  my $response = {};
  my $status = 200;
  if( $auth->verify_password( $self->param('pass'), $static ) ){
      $status = 200;
      $response->{token} = $tokens->get;
  } else {
      $status = 418;
      $response->{reason} = "being cringe";
  }
  
  $self->render(openapi => $response, status => $status);
}

1;

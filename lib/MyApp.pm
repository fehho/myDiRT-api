package MyApp;
use Mojo::Base 'Mojolicious', -signatures;
use MCE::Shared;
use CHI;
# This method will run once at server start
sub startup ($self) {

  our $cache = MCE::Shared->share ( CHI->new(
    driver => 'Memory',
    global => 1,
    expires_in => 3600
  ));

  # Load configuration from config file
  my $config = $self->plugin('JSONConfig');
  $self->plugin(OpenAPI => {spec => $self->static->file("api.json")->path});
  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Example#welcome');
}

1;

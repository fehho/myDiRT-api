package MyApp::Controller::Meta;
use Mojo::Base "Mojolicious::Controller";
use Mojo::JSON qw(decode_json encode_json);
sub health {
  # Validate input request or return an error document
  my $self = shift->openapi->valid_input or return;

  # Render back the same data as you received using the "openapi" handler
  $self->render(openapi => { status => "🙂" });
}

1;

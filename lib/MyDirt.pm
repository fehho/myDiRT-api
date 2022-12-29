package MyDirt;
use Mojo::Base 'Mojolicious', -signatures;
use MCE::Shared;
use CHI;
use MyDirt::Schema;

# This method will run once at server start
sub startup ($self) {

    our $cache = MCE::Shared->share(
        CHI->new(
            driver     => 'Memory',
            global     => 1,
            expires_in => 3600
        )
    );

    # Load configuration from config file
    our $config = MCE::Shared->share( $self->plugin('JSONConfig') );
    $self->plugin(
	OpenAPI => {
	    add_preflighted_routes => 0,
            spec     => $self->static->file("api.json")->path,
            security => {
                tokenAuthn => sub {
                    my ( $c, $definition, $scopes, $cb ) = @_;
                    my $error = undef;
                    if ( my $token = $c->req->param('token') ) {
                        $error = "Bad token"
                          unless $cache->get($token);
                    }
                    else {
                        $error = "No token seen";
                    }
                    $c->$cb($error);
                }
            }
        }
    );

    $self->defaults(openapi_cors_default_exchange_callback => sub ($c) {
	$c->res->headers->header("Access-Control-Allow-Origin" => "*");
	$c->res->headers->header("Access-Control-Allow-Headers" => 'Content-Type' => 'application/x-www-form-urlencoded');
        return undef;
    });
    # Configure the application
    $self->secrets( $config->{secrets} );
    $self->hook(before_dispatch => sub ($c) {
	$c->res->headers->access_control_allow_origin('*');
#	$c->res->headers->access_control_allow_header('*');
    });
}

1;

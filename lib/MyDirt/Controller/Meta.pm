package MyDirt::Controller::Meta;
use Mojo::Base "Mojolicious::Controller";
use Mojo::JSON qw(decode_json encode_json);

=head1 Meta.pm - Controller for actions about the server itself
If an action doesn't belong anywhere else, then it probably belongs here.
=cut

sub health {

=head2 health
GET endpoint which always sends a smiley face.
=cut
    
    # Validate input request or return an error document
    my $self = shift->openapi->valid_input or return;
    
    $self->render(openapi => { status => "🙂" });
}

1;

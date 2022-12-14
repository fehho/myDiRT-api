use Devel::Cover;
use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');

$t->get_ok('/api/health')->status_is(200)->json_is({status => "🙂"});

$t->post_ok('/api/get_token', form => { user => 'somebody@example.org', pass => 'not somebodys password password'} )->status_is(418);

my $token = $t->post_ok('/api/get_token', form =>
   { user => 'somebody@example.org', pass => 'baba booey' }
)->status_is(200)
->json_has('/token', 'got a token with good creds')
->tx->res->json->{token};

$t->post_ok('/api/check_token', form => { token => $token })
->status_is(200);

$t->post_ok('/api/entity', form => { token => $token })
->status_is(200)
->json_has('/name')
->json_has('/rank')
->json_has('/subordinates')
->json_has('/documents');

done_testing();

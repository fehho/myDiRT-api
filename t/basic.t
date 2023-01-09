use Devel::Cover;
use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyDirt');

$t->get_ok('/api/health')->status_is(200)->json_is({status => "🙂"});

$t->post_ok('/api/get_token', form => { user => 'somebody@example.org', pass => 'not somebodys password password'} )->status_is(401);

$t->post_ok('/api/get_token', form => {}, 'empty form')->status_is(401);
my $token = $t->post_ok('/api/get_token', form =>
   { user => 'Luffy', pass => 'baba booey' }
)->status_is(200)
->json_has('/token', 'got a token with good creds')
->tx->res->json->{token};
use feature 'say';
say $token;
$t->post_ok('/api/check_token', form => { token => "phonytoken" })
->status_is(401);
$t->post_ok('/api/check_token', form => { token => $token })
->status_is(200);

my $sub = $t->post_ok('/api/entity', form => { token => $token })
->status_is(200)
->json_has('/name')
->json_has('/rank')
->json_has('/subordinates')
->json_has('/documents')->tx->res->json->{subordinates};

$t->post_ok('/api/entity/sub', form => {
    token => $token,
    key => (keys %{$sub})[0]
})->status_is(200)
->json_has('/Name');

$t->post_ok('/api/entity/sub', form => {
    token => ':>',
    key => (keys %{$sub})[0]
})->status_is(401);

$t->post_ok('/api/entity/sub', form => {
    token => $token,
    key => 999
})->status_is(401);

$t->get_ok('/api/listFormTemplates')
->status_is(200)
->json_has('/0');

done_testing();

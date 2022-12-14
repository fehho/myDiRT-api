use Devel::Cover;
use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');
$t->get_ok('/api/hello')->status_is(200)->json_is({face => ":^)"});
$t->post_ok('/api/get_token', form => { user => 'somebody', pass => 'not somebodys password password'} )->status_is(418);
done_testing();

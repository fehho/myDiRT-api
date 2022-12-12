use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MyApp');
$t->get_ok('/api/hello')->status_is(200)->json_is({face => ":^)"});

done_testing();

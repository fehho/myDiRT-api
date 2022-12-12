use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {
    'Mojolicious' => '9.22',
    'Mojolicious::Plugin::OpenAPI' => 0,
    'OpenAPI::Client' => 0,
    'YAML::XS' => 0
  },
  test => {TESTS => 't/*.t'}
);

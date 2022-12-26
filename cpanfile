requires 'Mojolicious', '>= 9.19';
requires 'Mojolicious::Plugin::OpenAPI';
requires 'Crypt::Passphrase';
requires 'Crypt::Passphrase::Argon2';
requires 'Session::Token';
requires 'CHI';
requires 'Params::Util'; #unlisted dependency of String::RewritePrefix, which itself is a dependancy of CHI
requires 'MCE::Shared';
requires 'DBI', '>=1.643';
requires 'DBIx::Class::Schema';
requires 'DBD::ODBC';

on 'test' => sub {
    requires 'Test::More';
    requires 'Test::Mojo';
    requires 'Devel::Cover';
    requires 'Pod::Coverage';
};

feature 'schema', 'Deploy schema to ORM' => sub {
    requires 'DBIx::Class::Schema::Loader';
    requires 'SQL::Translator';
    requires 'Sub::Name';
}	 
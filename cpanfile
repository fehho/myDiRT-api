requires 'Mojolicious', '>= 9.19';
requires 'Mojolicious::Plugin::OpenAPI';
requires 'Crypt::Passphrase';
requires 'Crypt::Passphrase::Argon2';
requires 'Session::Token';
requires 'CHI';
requires 'Params::Util'; #unlisted dependency of String::RewritePrefix, which itself is a dependancy of CHI

#requires 'OpenAPI::Client';
#requires 'YAML::XS';
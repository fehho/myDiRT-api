use utf8;
package MyDirt::Schema::Result::TblLogin;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblLogin

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblLogin>

=cut

__PACKAGE__->table("tblLogin");

=head1 ACCESSORS

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 userloginid

  data_type: 'varchar'
  is_nullable: 0
  size: 15

=head2 userpassword

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "userloginid",
  { data_type => "varchar", is_nullable => 0, size => 15 },
  "userpassword",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</userid>

=back

=cut

__PACKAGE__->set_primary_key("userid");

=head1 RELATIONS

=head2 userid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblUser>

=cut

__PACKAGE__->belongs_to(
  "userid",
  "MyDirt::Schema::Result::TblUser",
  { userid => "userid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 11:52:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:M7N7wH5SLXn2epx9m/luaA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

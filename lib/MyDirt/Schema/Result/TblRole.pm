use utf8;
package MyDirt::Schema::Result::TblRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblRole

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblRoles>

=cut

__PACKAGE__->table("tblRoles");

=head1 ACCESSORS

=head2 roleid

  data_type: 'integer'
  is_nullable: 0

=head2 roletype

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "roleid",
  { data_type => "integer", is_nullable => 0 },
  "roletype",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</roleid>

=back

=cut

__PACKAGE__->set_primary_key("roleid");

=head1 RELATIONS

=head2 tbl_users

Type: has_many

Related object: L<MyDirt::Schema::Result::TblUser>

=cut

__PACKAGE__->has_many(
  "tbl_users",
  "MyDirt::Schema::Result::TblUser",
  { "foreign.roleid" => "self.roleid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 11:52:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KAnTgJzUFI5OAaktfkqysA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

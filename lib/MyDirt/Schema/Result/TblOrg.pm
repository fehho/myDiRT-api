use utf8;
package MyDirt::Schema::Result::TblOrg;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblOrg

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblOrgs>

=cut

__PACKAGE__->table("tblOrgs");

=head1 ACCESSORS

=head2 orgid

  data_type: 'integer'
  is_nullable: 0

=head2 orgname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 orgpersonid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "orgid",
  { data_type => "integer", is_nullable => 0 },
  "orgname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "orgpersonid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</orgid>

=back

=cut

__PACKAGE__->set_primary_key("orgid");

=head1 RELATIONS

=head2 orgpersonid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblOrgPerson>

=cut

__PACKAGE__->belongs_to(
  "orgpersonid",
  "MyDirt::Schema::Result::TblOrgPerson",
  { orgpersonid => "orgpersonid" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 tbl_users

Type: has_many

Related object: L<MyDirt::Schema::Result::TblUser>

=cut

__PACKAGE__->has_many(
  "tbl_users",
  "MyDirt::Schema::Result::TblUser",
  { "foreign.organizationid" => "self.orgid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-21 10:21:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7JbFW3/oGgtvLjlBWaV+kQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

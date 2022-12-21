use utf8;
package MyDirt::Schema::Result::TblOrgPerson;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblOrgPerson

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblOrgPersons>

=cut

__PACKAGE__->table("tblOrgPersons");

=head1 ACCESSORS

=head2 orgpersonid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 orgpersonfirstname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 orgpersonlastname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 orgrankid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "orgpersonid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "orgpersonfirstname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "orgpersonlastname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "orgrankid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</orgpersonid>

=back

=cut

__PACKAGE__->set_primary_key("orgpersonid");

=head1 RELATIONS

=head2 orgrankid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblRank>

=cut

__PACKAGE__->belongs_to(
  "orgrankid",
  "MyDirt::Schema::Result::TblRank",
  { rankid => "orgrankid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tbl_orgs

Type: has_many

Related object: L<MyDirt::Schema::Result::TblOrg>

=cut

__PACKAGE__->has_many(
  "tbl_orgs",
  "MyDirt::Schema::Result::TblOrg",
  { "foreign.orgpersonid" => "self.orgpersonid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-21 10:21:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:p173WLpMZWRhgkabNlBMlA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

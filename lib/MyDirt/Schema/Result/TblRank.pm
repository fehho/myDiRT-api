use utf8;
package MyDirt::Schema::Result::TblRank;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblRank

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblRank>

=cut

__PACKAGE__->table("tblRank");

=head1 ACCESSORS

=head2 rankid

  data_type: 'integer'
  is_nullable: 0

=head2 ranktype

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "rankid",
  { data_type => "integer", is_nullable => 0 },
  "ranktype",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</rankid>

=back

=cut

__PACKAGE__->set_primary_key("rankid");

=head1 RELATIONS

=head2 tbl_org_persons

Type: has_many

Related object: L<MyDirt::Schema::Result::TblOrgPerson>

=cut

__PACKAGE__->has_many(
  "tbl_org_persons",
  "MyDirt::Schema::Result::TblOrgPerson",
  { "foreign.orgrankid" => "self.rankid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tbl_users

Type: has_many

Related object: L<MyDirt::Schema::Result::TblUser>

=cut

__PACKAGE__->has_many(
  "tbl_users",
  "MyDirt::Schema::Result::TblUser",
  { "foreign.rankid" => "self.rankid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 11:52:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LHV75Fqguzsv1fbvyZRo3g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

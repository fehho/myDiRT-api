use utf8;
package MyDirt::Schema::Result::TblUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblUser

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblUser>

=cut

__PACKAGE__->table("tblUser");

=head1 ACCESSORS

=head2 userid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 hashkey

  data_type: 'uniqueidentifier'
  default_value: newid()
  is_nullable: 0

=head2 userfirstname

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 usermiddlename

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 userlastname

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 useremail

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 userphone

  data_type: 'varchar'
  is_nullable: 1
  size: 11

=head2 roleid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organizationid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 issubordinate

  data_type: 'bit'
  is_nullable: 1

=head2 rankid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 officesymbol

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "hashkey",
  {
    data_type     => "uniqueidentifier",
    default_value => \"newid()",
    is_nullable   => 0,
  },
  "userfirstname",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "usermiddlename",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "userlastname",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "useremail",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "userphone",
  { data_type => "varchar", is_nullable => 1, size => 11 },
  "roleid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "organizationid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "issubordinate",
  { data_type => "bit", is_nullable => 1 },
  "rankid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "officesymbol",
  { data_type => "varchar", is_nullable => 1, size => 4 },
);

=head1 PRIMARY KEY

=over 4

=item * L</userid>

=back

=cut

__PACKAGE__->set_primary_key("userid");

=head1 RELATIONS

=head2 organizationid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblOrg>

=cut

__PACKAGE__->belongs_to(
  "organizationid",
  "MyDirt::Schema::Result::TblOrg",
  { orgid => "organizationid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 rankid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblRank>

=cut

__PACKAGE__->belongs_to(
  "rankid",
  "MyDirt::Schema::Result::TblRank",
  { rankid => "rankid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 roleid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblRole>

=cut

__PACKAGE__->belongs_to(
  "roleid",
  "MyDirt::Schema::Result::TblRole",
  { roleid => "roleid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tbl_login

Type: might_have

Related object: L<MyDirt::Schema::Result::TblLogin>

=cut

__PACKAGE__->might_have(
  "tbl_login",
  "MyDirt::Schema::Result::TblLogin",
  { "foreign.userid" => "self.userid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tbl_user_subordinates_subordinateids

Type: has_many

Related object: L<MyDirt::Schema::Result::TblUserSubordinate>

=cut

__PACKAGE__->has_many(
  "tbl_user_subordinates_subordinateids",
  "MyDirt::Schema::Result::TblUserSubordinate",
  { "foreign.subordinateid" => "self.userid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tbl_user_subordinates_userids

Type: has_many

Related object: L<MyDirt::Schema::Result::TblUserSubordinate>

=cut

__PACKAGE__->has_many(
  "tbl_user_subordinates_userids",
  "MyDirt::Schema::Result::TblUserSubordinate",
  { "foreign.userid" => "self.userid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tbl_xref_user_docs

Type: has_many

Related object: L<MyDirt::Schema::Result::TblXrefUserDoc>

=cut

__PACKAGE__->has_many(
  "tbl_xref_user_docs",
  "MyDirt::Schema::Result::TblXrefUserDoc",
  { "foreign.userid" => "self.userid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-01-05 10:49:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KYJldOS5uqE/TT1wnPAGoA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

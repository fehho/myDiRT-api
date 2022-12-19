use utf8;
package MyDirt::Schema::Result::TblXrefUserDoc;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblXrefUserDoc

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblXRefUserDocs>

=cut

__PACKAGE__->table("tblXRefUserDocs");

=head1 ACCESSORS

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 docid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "docid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 docid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblDoc>

=cut

__PACKAGE__->belongs_to(
  "docid",
  "MyDirt::Schema::Result::TblDoc",
  { docid => "docid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QFmAd+U1BYozfrfmaqxd/Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

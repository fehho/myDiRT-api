use utf8;
package MyDirt::Schema::Result::TblDoc;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblDoc

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblDocs>

=cut

__PACKAGE__->table("tblDocs");

=head1 ACCESSORS

=head2 docid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 hashkey

  data_type: 'uniqueidentifier'
  is_nullable: 0

=head2 doc

  data_type: 'image'
  is_nullable: 0

=head2 doctypeid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 docwhere

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "docid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "hashkey",
  { data_type => "uniqueidentifier", is_nullable => 0 },
  "doc",
  { data_type => "image", is_nullable => 0 },
  "doctypeid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "docwhere",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</docid>

=back

=cut

__PACKAGE__->set_primary_key("docid");

=head1 RELATIONS

=head2 doctypeid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblDocType>

=cut

__PACKAGE__->belongs_to(
  "doctypeid",
  "MyDirt::Schema::Result::TblDocType",
  { doctypeid => "doctypeid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tbl_xref_user_docs

Type: has_many

Related object: L<MyDirt::Schema::Result::TblXrefUserDoc>

=cut

__PACKAGE__->has_many(
  "tbl_xref_user_docs",
  "MyDirt::Schema::Result::TblXrefUserDoc",
  { "foreign.docid" => "self.docid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-01-05 10:49:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0lZ396vuNnGvUuq8U2ImHg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

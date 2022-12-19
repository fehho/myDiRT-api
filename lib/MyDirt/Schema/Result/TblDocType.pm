use utf8;
package MyDirt::Schema::Result::TblDocType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblDocType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblDocTypes>

=cut

__PACKAGE__->table("tblDocTypes");

=head1 ACCESSORS

=head2 doctypeid

  data_type: 'integer'
  is_nullable: 0

=head2 doctypename

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 doctemplate

  data_type: 'image'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "doctypeid",
  { data_type => "integer", is_nullable => 0 },
  "doctypename",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "doctemplate",
  { data_type => "image", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</doctypeid>

=back

=cut

__PACKAGE__->set_primary_key("doctypeid");

=head1 RELATIONS

=head2 tbl_docs

Type: has_many

Related object: L<MyDirt::Schema::Result::TblDoc>

=cut

__PACKAGE__->has_many(
  "tbl_docs",
  "MyDirt::Schema::Result::TblDoc",
  { "foreign.doctypeid" => "self.doctypeid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 11:52:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uH2s4SL4rOqcSF1TPhuwLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

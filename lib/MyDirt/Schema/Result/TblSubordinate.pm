use utf8;
package MyDirt::Schema::Result::TblSubordinate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblSubordinate

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblSubordinate>

=cut

__PACKAGE__->table("tblSubordinate");

=head1 ACCESSORS

=head2 subordinateid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 subfirstname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 submiddlename

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 sublastname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "subordinateid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "subfirstname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "submiddlename",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "sublastname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</subordinateid>

=back

=cut

__PACKAGE__->set_primary_key("subordinateid");

=head1 RELATIONS

=head2 tbl_xref_user_subordinates

Type: has_many

Related object: L<MyDirt::Schema::Result::TblXrefUserSubordinate>

=cut

__PACKAGE__->has_many(
  "tbl_xref_user_subordinates",
  "MyDirt::Schema::Result::TblXrefUserSubordinate",
  { "foreign.subordinateid" => "self.subordinateid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 11:52:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4m+Uv+Pfp7tO2fBUku4BWw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

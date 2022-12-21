use utf8;
package MyDirt::Schema::Result::TblUserSubordinate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblUserSubordinate

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblUserSubordinates>

=cut

__PACKAGE__->table("tblUserSubordinates");

=head1 ACCESSORS

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 subordinateid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "subordinateid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 subordinateid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblUser>

=cut

__PACKAGE__->belongs_to(
  "subordinateid",
  "MyDirt::Schema::Result::TblUser",
  { userid => "subordinateid" },
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


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-21 11:04:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:L3HsRsO8npC/dlAE69CN7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

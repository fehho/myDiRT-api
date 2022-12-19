use utf8;
package MyDirt::Schema::Result::TblXrefUserSubordinate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::TblXrefUserSubordinate

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tblXRefUserSubordinate>

=cut

__PACKAGE__->table("tblXRefUserSubordinate");

=head1 ACCESSORS

=head2 userid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 subordinateid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "subordinateid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 RELATIONS

=head2 subordinateid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblSubordinate>

=cut

__PACKAGE__->belongs_to(
  "subordinateid",
  "MyDirt::Schema::Result::TblSubordinate",
  { subordinateid => "subordinateid" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 userid

Type: belongs_to

Related object: L<MyDirt::Schema::Result::TblUser>

=cut

__PACKAGE__->belongs_to(
  "userid",
  "MyDirt::Schema::Result::TblUser",
  { userid => "userid" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 11:52:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6NOa2xQ6VGeu1xZgtkoiRQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

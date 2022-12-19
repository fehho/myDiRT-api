use utf8;
package MyDirt::Schema::Result::Inventory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyDirt::Schema::Result::Inventory

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Inventory>

=cut

__PACKAGE__->table("Inventory");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'nvarchar'
  is_nullable: 1
  size: 50

=head2 quantity

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "nvarchar", is_nullable => 1, size => 50 },
  "quantity",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2022-12-19 10:39:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4l/fG+5kpIaXH1RWWp0Myw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

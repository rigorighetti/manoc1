package Manoc::DB::Result::IfStatus;
# Copyright 2011 by the Manoc Team
#
# This library is free software. You can redistribute it and/or modify
# it under the same terms as Perl itself.
use base 'DBIx::Class';
use strict;
use warnings;

__PACKAGE__->load_components(qw/ Core/);
__PACKAGE__->table('if_status');


__PACKAGE__->add_columns(
			 'device' => {
			     data_type		=> 'varchar',
			     is_foreign_key	=> 1,
			     is_nullable	=> 0,
			     size		=> 15
			     },
			 'interface' => {
			     data_type		=> 'varchar',
			     is_nullable	=> 0,
			     size		=> 64
			     },
			 'description' => {
			     data_type		=> 'varchar',
			     size		=> 128,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'up' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'up_admin' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'duplex' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'duplex_admin' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'speed' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'stp_state' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'cps_enable' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'cps_status' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'cps_count' => {
			     data_type		=> 'varchar',
			     size		=> 16,
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 'vlan' => {
			     data_type		=> 'integer',
			     is_nullable	=> 1,
			     default		=> 'NULL'		 
			     },
			 );

__PACKAGE__->belongs_to(device_info => 'Manoc::DB::Result::Device', 'device');
__PACKAGE__->set_primary_key('device', 'interface');

1;

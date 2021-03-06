package Manoc::DB::Result::Mat;
# Copyright 2011 by the Manoc Team
#
# This library is free software. You can redistribute it and/or modify
# it under the same terms as Perl itself.

use base 'DBIx::Class';
use strict;
use warnings;

__PACKAGE__->load_components(qw/ Core /);
__PACKAGE__->table('mat');


__PACKAGE__->add_columns(
			 'macaddr' => {
			     data_type		=> 'varchar',
			     is_nullable	=> 0,
			     size 		=> 17
			     },
			 'device' => {
			     data_type		=> 'varchar',
			     is_nullable	=> 0,
			     size		=> 15,
			     is_foreign_key	=> 1,
			     },
			 'interface' => {
			     data_type		=> 'varchar',
			     is_nullable	=> 0,
			     size		=> 64,
			     },
			 'firstseen' => {
			     data_type		=> 'int',
			     is_nullable	=> 0,
			     size 		=> 11
			     },
			 'lastseen' => {
			     data_type		=> 'int',
			     default_value	=> 'NULL',
			     is_nullable	=> 1,
			     },
			 'vlan' => {
			     data_type		=> 'int',
			     default_value	=> 1,
			     is_nullable	=> 0,
			     size		=> 11
			     },
			 'archived' => {
			     data_type		=> 'int',
			     default_value	=> 0,
			     is_nullable	=> 0,
			     size		=> 1
			     },
			 );

__PACKAGE__->set_primary_key('macaddr', 'device', 'firstseen', 'vlan');

__PACKAGE__->belongs_to('device_entry' => 'Manoc::DB::Result::Device', 'device');


sub search_multihost_interfaces : ResultSet {
    my ($self) = @_;
    return $self->search(
			 { 'archived' => 0 },
			 {
			     select => 
				 [
				  'me.device' , 
				  'me.interface', 
				  {
				      count => { distinct => 'macaddr' } 
				  },
				  'description'
				  ],   
				      
			     as => [ 'device', 'interface', 'count', 'description' ],
			     group_by => [ 'device', 'interface' ],		     
			     having => { 'COUNT(DISTINCT(macaddr))' => { '>', 1 } },
			     order_by => [ 'me.device', 'me.interface' ],
			     alias => 'me',
			     from  => [ 
					{ me => 'mat' },
					[
					 { 'ifstatus' => 'if_status' },
					 { 
					     'ifstatus.device'    => 'me.device',
					     'ifstatus.interface' => 'me.interface',
					 }
					 ]
					]				    
				    });
}
1;




#
#  LFIndexController.rb
#  Annotate
#
#  Created by Daniel de Kok on 5/17/10.
#  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'
require 'flan_client'

class LFIndexController < OSX::NSObject
	include OSX
	
	def initialize
		c = FlanClient::FlanClient.new('http://localhost:3000','','')
		@keys = c.lf_keys
	end
	
	def tableViewSelectionDidChange_(notification)
		row = notification.object.selectedRow
		
		if row >= 0 then
			center = NSNotificationCenter.defaultCenter
			center.postNotificationName_object_userInfo_("lfSelected", self,
				@keys[row])
		end
	end
	
	def numberOfRowsInTableView(lfTable)
		@keys.length
	end
	
	def tableView_objectValueForTableColumn_row(lfTable, column, row)
		@keys[row]['key']
	end
end

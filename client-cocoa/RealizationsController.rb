#
#  RealizationsController.rb
#  Annotate
#
#  Created by Daniel de Kok on 5/17/10.
#  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class RealizationsController < OSX::NSObject
	include OSX

	ib_outlet :lfController, :realizationsView
	
	def initialize()
		@flanClient = FlanClient::FlanClient.new('http://localhost:3000','','')
		@realizations = []
	end

	def	awakeFromNib
		center = NSNotificationCenter.defaultCenter
		center.addObserver_selector_name_object(self, :lfSelected,
			'lfSelected', @lfController)
	end
	
	def lfSelected(notification)
		lfId = notification.userInfo['id']
		@realizations = @flanClient.realizations(lfId)
		@realizationsView.reloadData
	end
	
	def numberOfRowsInTableView(relsTable)
		@realizations.length
	end
	
	def tableView_objectValueForTableColumn_row(relsTable, column, row)
		@realizations[row]
	end

end

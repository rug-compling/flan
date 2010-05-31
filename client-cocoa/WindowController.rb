#
#  WindowController.rb
#  Annotate
#
#  Created by Daniel de Kok on 5/16/10.
#  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class WindowController < OSX::NSObject
	include OSX
	
	ib_outlet :window, :lf_view
	
	def awakeFromNib()
		@window.delegate = self
	end

	def windowWillClose(notification)
		NSApp.terminate(self)
	end	
end

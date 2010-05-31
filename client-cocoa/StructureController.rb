#
#  StructureController.rb
#  Annotate
#
#  Created by Daniel de Kok on 5/17/10.
#  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class StructureController < OSX::NSObject
	include OSX
	
	ib_outlet :pdfView, :lfController
	
	def initialize
		@flanClient = FlanClient::FlanClient.new('http://localhost:3000','','')
	end
	
	
	def	awakeFromNib
		center = NSNotificationCenter.defaultCenter
		center.addObserver_selector_name_object(self, :lfSelected,
			'lfSelected', @lfController)
	end
	
	def lfSelected(notification)
		lfId = notification.userInfo['id']
		pdf = @flanClient.structurePDF(lfId)
		dat = NSData.dataWithRubyString(pdf)
		@doc = PDFDocument.alloc.initWithData_(dat)
		@pdfView.setDocument_(@doc)
	end
	
end

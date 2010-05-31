class StructuresController < ApplicationController
  def show
    logical_form = LogicalForm.find(params[:logical_form_id])

    stylesheet_doc = XML::Document.file(File.join(RAILS_ROOT, 'stylesheets', 'adt2tree.xsl'))
    stylesheet = XSLT::Stylesheet.new(stylesheet_doc)
    
    doc = XML::Document.string(logical_form.data)
    result = stylesheet.apply(doc)
    
    @svg = result.to_s
    @pdf = Base64::decode64(logical_form.pdf)

    respond_to do |format|
      format.xml  { render :xml => @svg }
      format.pdf do
        send_data @pdf, :type => "application/pdf", :disposition => 'inline'
        return
      end
      #format.json { render :json => @svg }
    end
  end
end
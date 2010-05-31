class LogicalFormsController < ApplicationController
  def index
    @logical_forms = LogicalForm.find(:all, :select => 'id, key')

    respond_to do |format|
      format.xml  { render :xml => @logical_forms }
      format.json { render :json => @logical_forms }
    end
  end

  def show
    @logical_form = LogicalForm.find(params[:id], :include => :realization)

    respond_to do |format|
      format.xml  { render :xml => @logical_form.to_xml(:include => :realization) }
      format.json { render :json => @logical_form.to_json(:include => :realization) }
    end
  end
end

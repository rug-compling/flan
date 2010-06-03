class LogicalFormsController < ApplicationController
  def index
    @logical_forms = LogicalForm.find(:all,
    :joins => 'LEFT JOIN judgments ON judgments.logical_form_id = logical_forms.id',
    :select => 'logical_forms.id AS id, key, COUNT(DISTINCT judgments.user_id) AS judgmentCount',
    :group => 'logical_forms.id')
    
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

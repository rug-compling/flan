class RealizationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    uid = current_user.id

    @realizations = Realization.find(:all,
      :conditions => "realizations.logical_form_id = '#{params[:logical_form_id]}'",
      :joins => "LEFT JOIN judgments ON judgments.realization_id = realizations.id AND judgments.user_id = #{uid}",
      :select => "realizations.*, judgments.id AS judgment_id, CASE WHEN judgments.user_id IS NULL THEN 0 ELSE 1 END AS most_fluent")

    respond_to do |format|
      format.xml  { render :xml => @realizations }
      format.json { render :json => @realizations }
    end
  end
end
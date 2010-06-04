class RealizationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @realization = Realization.new(params[:realization])
    uid = current_user.id
    @realization.user_id = uid
    @realization.published = 0

    respond_to do |format|
      if @realization.save
        format.xml  { render :xml => @realization, :status => :created, :location => @logical_form }
        format.json  { render :json => @realization, :status => :created, :location => @logical_form }
      else
        format.xml  { render :xml => @realization.errors, :status => :unprocessable_entity }
        format.json  { render :json => @realization.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    uid = current_user.id

    @realizations = Realization.find(:all,
      :conditions => ["realizations.logical_form_id = ? AND realizations.published = ?", params[:logical_form_id], true],
      :joins => "LEFT JOIN judgments ON judgments.realization_id = realizations.id AND judgments.user_id = #{uid}",
      :select => "realizations.*, judgments.id AS judgment_id, CASE WHEN judgments.user_id IS NULL THEN 0 ELSE 1 END AS most_fluent")

    realizations_user = Realization.find(:all,
      :conditions => ["realizations.logical_form_id = ? AND realizations.user_id = ? AND
        realizations.published = ?", params[:logical_form_id], uid, false],
      :joins => "LEFT JOIN judgments ON judgments.realization_id = realizations.id AND judgments.user_id = #{uid}",
      :select => "realizations.*, judgments.id AS judgment_id, CASE WHEN judgments.user_id IS NULL THEN 0 ELSE 1 END AS most_fluent")
    
    @realizations.concat(realizations_user)

    respond_to do |format|
      format.xml  { render :xml => @realizations }
      format.json { render :json => @realizations }
    end
  end
end
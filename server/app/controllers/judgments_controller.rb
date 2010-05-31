class JudgmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @judgment = Judgment.new(params[:judgment])
    uid = current_user.id
    @judgment.user_id = uid

    respond_to do |format|
      if @judgment.save
        format.xml  { render :xml => @judgment, :status => :created, :location => @judgment }
        format.json  { render :json => @judgment, :status => :created, :location => @judgment }
      else
        format.xml  { render :xml => @judgment.errors, :status => :unprocessable_entity }
        format.json  { render :json => @judgment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    uid = current_user.id
    @judgment = Judgment.find(params[:id], :conditions => "user_id = '#{uid}'")
    @judgment.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end

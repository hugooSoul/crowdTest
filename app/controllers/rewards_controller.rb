class RewardsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_project

  def new
    @reward = @project.rewards.build
    respond_to do |format|
      format.html
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

end

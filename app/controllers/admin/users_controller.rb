class Admin::UsersController < Admin::ApplicationController
  before_action :pundit_authorize

  def index
    @users = User.all.asc(:first_name, :last_name)
  end

  def show
    @user = User.find(params[:id])
    @exams = @user.exams
  end

  def pundit_authorize
    authorize (@user || User)
  end
end

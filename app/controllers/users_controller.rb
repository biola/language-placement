class UsersController < ApplicationController
  def index
    @users = User.all.asc(:first_name, :last_name)
  end

  def show
    @user = User.find(params[:id])
    @exams = @user.exams
  end
end
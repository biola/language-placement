class TypesController < ApplicationController
  before_action :pundit_authorize

  def index
    @exams = Type.all.asc(:name).map { |et| et.exams.where(user: current_user).first_or_initialize }
  end

  def pundit_authorize
    authorize (@type || Type)
  end
end

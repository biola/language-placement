class TypesController < ApplicationController
  def index
    @exams = Type.all.asc(:name).map { |et| et.exams.where(user: current_user).first_or_initialize }
  end
end

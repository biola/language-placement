class ExamTypesController < ApplicationController
  def index
    @exam_types = ExamType.all.asc(:name)
  end
end
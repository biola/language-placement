class Admin::ExamsController < Admin::ApplicationController
  before_action :pundit_authorize

  def index
    exams = Exam.all.asc(:first_name, :last_name)
    exams.each_with_index do |exam, index|
      if index == 0
        @exam_attempts = exam.attempts
      else
        @exam_attempts += exam.attempts
      end
    end
  end

  def pundit_authorize
    authorize (@exam || Exam)
  end
end

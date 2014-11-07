class ExamController < ApplicationController
  def create
    exam = Exam.new(exam_params)

    #TODO exam.user = current_user

    exam.exam_attempts.build

    if exam.save
      #TODO redirect to testing site
    else
      redirect_to exams_path, alert: exam.errors.full_messages.join(' ')
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:exam_type_id)
  end
end
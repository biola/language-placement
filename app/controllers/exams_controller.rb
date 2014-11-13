class ExamsController < ApplicationController
  def create
    exam = Exam.new(exam_params)

    #TODO exam.user = current_user

    attempt = exam.exam_attempts.build

    if exam.save
      redirect_to ExamUrlGenerator.new(attempt.uid, exam.exam_type_code).exam_url('http://www.google.com')
    else
      redirect_to exams_path, alert: exam.errors.full_messages.join(' ')
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:exam_type_id)
  end
end
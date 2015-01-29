class ExamsController < ApplicationController
  def create
    exam = Exam.new(exam_params)

    exam.user = current_user

    # attempt = exam.attempts.build

    if exam.save
      # redirect_to ExamUrlGenerator.new(attempt.uid, exam.type_code).exam_url('http://www.google.com')
      redirect_to exam_path(exam)
    else
      redirect_to types_path, alert: exam.errors.full_messages.join(' ')
    end
  end

  def show
    @exam = Exam.find(params[:id])
    @unfinished_exams = @exam.attempts.unfinished.started_at_desc
    @finished_exams = @exam.attempts.finished.completed_at_desc
  end

  private

  def exam_params
    params.require(:exam).permit(:type_id)
  end
end

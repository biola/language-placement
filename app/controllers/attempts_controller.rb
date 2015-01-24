class AttemptsController < ApplicationController
  def create
    exam = Exam.find(params[:exam_id])
    attempt = exam.attempts.new

    if attempt.save
      redirect_to webcape_url(attempt)
    else
      redirect_to exam_path(exam), alert: exam.errors.full_messages.join(' ')
    end
  end

  def show
    exam = Exam.find(params[:exam_id])
    @exam_attempt = exam.attempts.find(params[:id])

    if @exam_attempt.unfinished?
      redirect_to webcape_url(@exam_attempt)
    end
  end

  def complete
    exam = Exam.find(params[:exam_id])
    attempt = exam.attempts.find(params[:id])

    if attempt.score.nil?
      attempt.import_score!
    end

    redirect_to exam_attempt_path exam, attempt
  end

  private

  def webcape_url(attempt)
    return_url = complete_exam_attempt_url attempt.exam, attempt
    ExamUrlGenerator.new(attempt.uid, attempt.exam.type_code).exam_url(return_url)
  end
end

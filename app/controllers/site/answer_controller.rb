class Site::AnswerController < SiteController
  def answer_correction
    @answer = Answer.find(params[:answer_id])
  end
end

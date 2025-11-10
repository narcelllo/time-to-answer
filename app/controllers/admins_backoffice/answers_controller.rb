class AdminsBackoffice::AnswersController < AdminsBackofficeController
  before_action :set_answers, only: [ :edit, :update, :destroy ]
  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      redirect_to admins_backoffice_questions_path, notice: "Resposta deletada com sucesso."
    else
      redirect_to admins_backoffice_questions_path, alert: "Não foi possível deletar a resposta."
    end
  end
  private
  def set_answers
    @answer = Answer.find(params[:id])
  end
end

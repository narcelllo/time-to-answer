class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [ :edit, :update, :destroy ]
  before_action :set_subjects, only: [ :new, :edit, :create, :update ]
  before_action :set_answers, only: [ :new, :edit, :create, :update ]
  def index
    # @question = Question.all.page(params[:page]).per(5)
    @question = Question.includes(:subject, :answers).page(params[:page]).per(5)
  end
  def new
    @question = Question.new
    4.times { @question.answers.build }
  end
  def create
    @question = Question.new(params_question)
    if @question.save()
      redirect_to admins_backoffice_questions_path, notice: "Assunto criado com sucesso."
    else
      render :new
    end
  end
  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Assunto deletado com sucesso."
    else
      redirect_to admins_backoffice_questions_path, alert: "Não foi possível deletar o assunto."
    end
  end
  def edit
    4.times { @question.answers.build }
  end
  def update
    if @question.update(params_question)
      redirect_to admins_backoffice_questions_path, notice: "Assunto atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def params_question
    params.require(:question).permit(:description, :subject_id, answers_attributes: [ :id, :description, :correct, :_destroy ])
  end

  def set_subjects
    @subjects = Subject.all
  end

  def set_answers
    @answers = Answer.all
  end
end

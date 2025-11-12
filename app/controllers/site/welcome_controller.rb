class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:subject).all
  end
end

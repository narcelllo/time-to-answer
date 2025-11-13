class Site::SearchController < SiteController
  def index
    @questions = Question._search_(params[:query], params[:page])
  end
end

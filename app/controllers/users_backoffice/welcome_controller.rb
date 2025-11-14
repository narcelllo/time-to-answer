class UsersBackoffice::WelcomeController < UsersBackofficeController
  def index
    @user = current_user
  end
end

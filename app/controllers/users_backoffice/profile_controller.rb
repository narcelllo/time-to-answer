class UsersBackoffice::ProfileController < UsersBackofficeController
  def edit
    @user = current_user
  end
end

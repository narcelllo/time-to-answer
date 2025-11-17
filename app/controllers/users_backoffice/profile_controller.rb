class UsersBackoffice::ProfileController < UsersBackofficeController
  before_action :set_user
  def edit
  end

  def update_email
    if @user.update(params_email)
      redirect_to users_backoffice_welcome_index_path, notice: "E-mail atualizado!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_name
    if @user.update(params_info)
      redirect_to users_backoffice_welcome_index_path, notice: "Dados atualizados!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_password
    unless @user.valid_password?(params_password[:current_password])
      @user.errors.add(:current_password, "não confere")
      return render :edit, status: :unprocessable_entity
    end

    if @user.update(params_password.except(:current_password))
      redirect_to users_backoffice_welcome_index_path, notice: "Senha atualizada!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def params_email
    params.require(:user).permit(:email)
  end

  def params_info
    params.require(:user).permit(:first_name, :last_name)
  end

  def params_password
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end

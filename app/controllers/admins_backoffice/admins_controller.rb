class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    # @admins = Admin.pluck(:id, :email, :created_at)
    @admins = Admin.all
  end
  def edit
    @admin = Admin.find(params[:id])
  end
  def update
    @admin = Admin.find(params[:id])
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation, :current_password)

    # Se o usuário informou uma nova senha...
    if params_admin[:password].present?
      # Verifica a senha atual usando Devise
      if @admin.valid_password?(params_admin[:current_password])
        if @admin.update(params_admin.except(:current_password))
          redirect_to admins_backoffice_admins_path
        else
          render :edit, status: :unprocessable_entity
        end
      else
        @admin.errors.add(:current_password)
        render :edit, status: :unprocessable_entity
      end
    else
      # Atualiza apenas o email se senha não foi alterada
      if @admin.update(params_admin.except(:password, :password_confirmation, :current_password))
        redirect_to admins_backoffice_admins_path, notice: "Dados atualizados com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end
end

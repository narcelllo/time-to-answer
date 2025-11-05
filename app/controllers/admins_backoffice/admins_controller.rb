class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: [ :edit, :update, :destroy ]
  def index
    # @admins = Admin.pluck(:id, :email, :created_at)
    @admins = Admin.all.page(params[:page]).per(5)
  end
  def new
    @admin = Admin.new
  end
  def create
    @admin = Admin.new(params_admin)
    if @admin.save()
      redirect_to admins_backoffice_admins_path, notice: "Administrador criado com sucesso."
    else
      render :new
    end
  end
  def destroy
    @admin = Admin.find(params[:id])
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador deletado com sucesso."
    else
      redirect_to admins_backoffice_admins_path, alert: "Não foi possível deletar o administrador."
    end
  end
  def edit
  end
  def update
    if params_admin[:password].present?
      if @admin.valid_password?(params_admin[:current_password])
        if @admin.update(params_admin.except(:current_password))
          redirect_to admins_backoffice_admins_path, notice: "Senha atualizada com sucesso."
        else
          render :edit, status: :unprocessable_entity
        end
      else
        @admin.errors.add(:current_password, "não é válida")
        render :edit, status: :unprocessable_entity
      end
    else
      if @admin.update(params_admin.except(:password, :password_confirmation, :current_password))
        redirect_to admins_backoffice_admins_path, notice: "Dados atualizados com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation, :current_password)
  end
end

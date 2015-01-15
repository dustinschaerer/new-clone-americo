class Admin::AdminUsersController < AdminController

  before_action :authenticate_admin_user!

  def index
    @admin_users = AdminUser.order("sign_in_count DESC")
  end

  def show
    @admin_user = AdminUser.find(params[:id])
  end

end

class Admin::UsersController < AdminController

  before_action :authenticate_admin_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order("id DESC").page(params[:page]).per(50)
    @all_users_count = User.all.count
  end

  def show
    @users_orders = Order.where(user_id: params[:id])
    @users_quotes = Quote.where(user_id: params[:id])
    @users_purchases = Purchase.where(user_id: params[:id])
    # @users =

  end

  def edit

  end

  def update

  end

  def destory

  end

  def assign_groups_for
    users = User.update_all({user_group_id: params[:user_group][:id]}, {id: params[:user_ids]})
    redirect_to admin_users_path(params)
  end

  def remove_from_group_for
     users = User.update_all({user_group_id: nil}, {id: params[:user_ids]})
    redirect_to admin_user_groups_path(params)
  end

  def retrieve_for_autocomplete
    @users = User.order(:email).where("email like ?", "%#{params[:term]}%")
    render json: @users.map(&:email)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email_message_id, :last_sent_on)
    end

end

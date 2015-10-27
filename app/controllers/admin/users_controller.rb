class Admin::UsersController < AdminController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_admin_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort] == nil && params[:email] == nil
      @users = User.order("id DESC").page(params[:page]).per(50)
    elsif params[:email]
      @users = User.where("email ILIKE ?", "%#{params[:email]}").order(id: :desc).page(params[:page]).per(50)
    elsif params[:sort] != nil
      @users = User.order(sort_column.to_sym => sort_direction.to_sym).page(params[:page]).per(50)
    end
    @all_users_count = User.all.count
  end

  def show
    @users_orders = Order.where(user_id: params[:id])
    @users_quotes = Quote.where(user_id: params[:id])
    @users_purchases = Purchase.where(user_id: params[:id])
  end

  def edit

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destory

  end

  def update_groups_for
    if params[:commit] == "Assign Checked to selected User Group"
      users = User.update_all({user_group_id: params[:user_group][:id]}, {id: params[:user_ids]})
      redirect_to admin_users_path(params)

    elsif params[:commit] == "Remove Checked from User Group"
      users = User.update_all({user_group_id: nil}, {id: params[:user_ids]})
      redirect_to admin_users_path(params)

    else
      redirect_to admin_users_path(params)
    end
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
      params.require(:user).permit(:name, :email_message_id, :last_sent_on, :sort_direction, :sort_column, :subscribed, :user_group_id)
    end

    def sort_column
      params[:sort] || "id"
    end

    def sort_direction
      params[:direction] || "desc"
    end

end

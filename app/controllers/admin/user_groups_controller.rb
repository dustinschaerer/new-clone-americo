class Admin::UserGroupsController < AdminController

  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/user_groups
  # GET /admin/user_groups.json
  def index
    @user_groups = UserGroup.all
    @user_group = UserGroup.new

  end

  # GET /admin/user_groups/1
  # GET /admin/user_groups/1.json
  def show
  end

  # GET /admin/user_groups/new
  def new
    @user_group = UserGroup.new
  end

  # GET /admin/user_groups/1/edit
  def edit
  end

  # POST /admin/user_groups
  # POST /admin/user_groups.json
  def create
    @user_group = UserGroup.new(user_group_params)

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to admin_user_groups_path, notice: 'User group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/user_groups/1
  # PATCH/PUT /admin/user_groups/1.json
  def update
    respond_to do |format|
      if @user_group.update(user_group_params)
        format.html { redirect_to [:admin, admin_user_groups_path], notice: 'User group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/user_groups/1
  # DELETE /admin/user_groups/1.json
  def destroy
    @user_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_groups_url, notice: 'User group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_from_group_for
     users = User.update_all({user_group_id: params[:user_group][:id]}, {id: params[:user_ids]})
    redirect_to admin_user_groups_path(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :email_message_id, :last_sent_on)
    end
end

class Admin::UserGroupsController < AdminController

  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/user_groups
  # GET /admin/user_groups.json
  def index
    @user_groups = UserGroup.all
    @user_group = UserGroup.new
    @purchase_groups = UserGroup.where("kind = ?", "Purchases").order(:name)
    @quote_groups = UserGroup.where("kind = ?", "Quotes").order(:name)
    @sample_groups = UserGroup.where("kind = ?", "Samples").order(:name)

  end

  # GET /admin/user_groups/1
  # GET /admin/user_groups/1.json
  def show
    @users = @user_group.users.order(:id)
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
        format.html { redirect_to admin_user_groups_path, notice: 'User group was successfully updated.' }
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
    users = User.update_all({user_group_id: nil}, {id: params[:user_ids]})
    redirect_to admin_user_groups_path(params)
  end

  def sort_users_into_groups
    group_cutoff_number = 251

    all_users = User.all.sort

    #################################################
    # Setup Different User Groups for sorting into  #
    #################################################
    @purchase_groups = UserGroup.where("kind = ?", "Purchases").order(:name)
    purchase_user_count = 0
    current_purchase_group = @purchase_groups.first
    @quote_groups = UserGroup.where("kind = ?", "Quotes").order(:name)
    quote_user_count = 0
    current_quote_group = @quote_groups.first
    @order_groups = UserGroup.where("kind = ?", "Samples or Catalogs").order(:name)
    order_user_count = 0
    current_order_group = @order_groups.first
    @new_users_groups = UserGroup.where("kind = ?", "New Users").order(:name)
    new_users_user_count = 0
    current_new_users_group = @new_users_groups.first

    # loop over all users
    all_users.each do |user|

      # if this user has any purchases
      if user.purchases.present?
        purchase_user_count = purchase_user_count + 1

        # if purchase user count hasn't exceeded the 250 user limit
        if purchase_user_count < group_cutoff_number
          # assign user to the Current Purchase Group (starts with Purchase Group 1)
          user.user_group_id = current_purchase_group.id
          user.save!
        # else if purchase user count is 251
        else
          # split purchase group name into array on the trailing integer
          purchase_array = current_purchase_group.name.reverse.split(" ", 2).map(&:reverse).reverse
          # increment the integer in the group name within the array, and join it back together
          purchase_array[1] = (purchase_array[1].to_i + 1).to_s
          purchase_record_string = purchase_array.join(" ")
          # find or create a new user group with the created string and with "kind" set to 'Purchases'
          current_purchase_group = UserGroup.find_or_create_by(name: purchase_record_string, kind: "Purchases")
          # assign user_group for user
          user.user_group_id = current_purchase_group.id
          user.save!
          # reset counter to include this record
          purchase_user_count = 1
        end
      # Since this user does not have any purchases, if this user has any quotes
      elsif user.quotes.present? && user.purchases.blank?
        quote_user_count = quote_user_count + 1
        # if quote user count hasn't exceeded the 250 user limit
        if quote_user_count < group_cutoff_number
          # assign user to the Current Quote Group (starts with Quote Group 1)
          user.user_group_id = current_quote_group.id
          user.save!
        # else if quote user count is 251
        else
          # split purchase group name into array on the trailing integer
          quote_array = current_quote_group.name.reverse.split(" ", 2).map(&:reverse).reverse
          # increment the integer in the group name within the array, and join it back together
          quote_array[1] = (quote_array[1].to_i + 1).to_s
          quote_record_string = quote_array.join(" ")
          # find or create a new user group with the created string and with "kind" set to 'quotes'
          current_quote_group = UserGroup.find_or_create_by(name: quote_record_string, kind: 'Quotes')

          # assign user_group for user
          user.user_group_id = current_quote_group.id
          user.save!
          # reset counter to include this record
          quote_user_count = 1
        end
      # Since this user does not have purchases or quotes, if this user has ordered a catalog
      elsif user.orders.present?
        order_user_count = order_user_count + 1
        # if quote user count hasn't exceeded the 250 user limit
        if order_user_count < group_cutoff_number
          # Put this user in the "Only ordered a Catalog" User Group
          user.user_group_id = current_order_group.id
          user.save!
        # else if order user count is 251
        else
          # split quote group name into array on the trailing integer
          order_array = current_order_group.name.reverse.split(" ", 2).map(&:reverse).reverse
          # increment the integer in the group name within the array, and join it back together
          order_array[1] = (order_array[1].to_i + 1).to_s
          order_record_string = order_array.join(" ")
          # find or create a new user group with the created string and with "kind" set to 'Samples or Catalogs'
          current_order_group = UserGroup.find_or_create_by(name: order_record_string, kind: 'Samples or Catalogs')
          # Put this user in the "Only ordered a Catalog" User Group
          user.user_group_id = current_order_group.id
          user.save!
          # reset order counter to include this record
          order_user_count = 1
        end
      # Since this user DOES NOT have any purchases, quotes, or orders(samples or catalogs)
      # this is a "New User"
      else
        new_users_user_count = new_users_user_count + 1
        # if new users user count hasn't exceeded the 250 user limit
        if new_users_user_count < group_cutoff_number
          # assign user to the Current New users Group (starts with New Users Group 1)
          user.user_group_id = current_new_users_group.id
          user.save!
        # else if new users user count is 251
        else
           # split quote group name into array on the trailing integer
          new_users_array = current_new_users_group.name.reverse.split(" ", 2).map(&:reverse).reverse
          # increment the integer in the group name within the array, and join it back together
          new_users_array[1] = (new_users_array[1].to_i + 1).to_s
          new_users_record_string = new_users_array.join(" ")
          # find or create a new user group with the created string and with "kind" set to 'Samples or Catalogs'
          current_new_users_group = UserGroup.find_or_create_by(name: new_users_record_string, kind: 'New Users')
          # reset new_users counter to include this record
          user.user_group_id = current_new_users_group.id
          user.save!
          new_users_user_count = 1
        end
      end
    end
    redirect_to admin_user_groups_path
  end


  ############
  # TODO begin
  ############
  def remove_all_users_from_all_groups

  end
  ############
  # TODO end
  ############





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :email_message_id, :last_sent_on, :kind)
    end
end

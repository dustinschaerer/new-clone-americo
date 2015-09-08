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
    users = User.update_all({user_group_id: nil}, {id: params[:user_ids]})
    redirect_to admin_user_groups_path(params)
  end

  def sort_users_into_groups
    all_users = User.all.sort
    # raise all_users.inspect
    # successfully prints out all Users

    all_users.each do |user|
      # if this user has any purchases
      if user.purchases.present?
        user.purchases.each do |purchase|
          purchase.lines.each do |line|
            # if this line is for a table cover
            if (line.quote_product_id == 1) || (line.quote_product_id == 2) || (line.quote_product_id == 13)
              purchase_contains_table_cover = true
            # elsif this line is for a roll good
            elsif (line.quote_product_id == 10) || (line.quote_product_id == 11) || (line.quote_product_id == 12) || (line.quote_product_id == 17)
              purchase_contains_roll_good = true
            # else this a different type of purchase
            else
              purchase_contains_other = true
            end
          end
        end
        #########################################
        # DECIDE WHICH USER GROUP TO PUT USER IN
        #########################################
        # if user has purchased both table covers(TC) and roll goods/upholstery rolls(RGUP)
        # then set the user into group: "Purchased both VTC and RGUP"
        user.user_group_id = 4
        user.save!

      # Since this user does not have any purchases, if this user has any quotes
      elsif user.quotes.present?
        # if user has requested quotes both table covers(TC) and roll goods/upholstery rolls(RGUP)
        # then set the user into group: "Purchased both VTC and RGUP"
        user.quotes.each do |quote|
          quote.lines.each do |line|
            if (line.quote_product_id == 1) || (line.quote_product_id == 2) || (line.quote_product_id == 13)
              quote_contains_table_cover = true
            # elsif this line is for a roll good
            elsif (line.quote_product_id == 10) || (line.quote_product_id == 11) || (line.quote_product_id == 12) || (line.quote_product_id == 17)
              quote_contains_roll_good = true
            # else this a different type of quote
            else
              quote_contains_other = true
            end
          end
        end
        #########################################
        # DECIDE WHICH USER GROUP TO PUT USER IN
        #########################################
        user.user_group_id = 5
        user.save!
        # if user has requested quotes for both table covers(TC) and roll goods/upholstery rolls(RGUP)
        # then set the user into group: "Quotes for both VTC and RGUP"

        # if user has requested quotes only table covers(TC)
        # then set the user into group: "Quotes for VTC

        # if user has requested quotes only roll goods/upholstery rolls(RGUP)
        # then set the user into group: "Quotes for RGUP"

      # Since this user does not have purchases or quotes, if this user has ordered a catalog
      elsif user.orders.present?
        # Put this user in the "Only ordered a Catalog" User Group
        user.user_group_id = 6
        user.save!
      else
        user.user_group_id = 7
        user.save!
      end

    end
    redirect_to admin_user_groups_path
  end

  # # find users with catalog orders only
  # def users_with_orders_only
  #   users = User.joins(:orders, :quotes, :purchases).where()
  # end

  # if current_user.id == @user.id
  #   # lookup the orders belonging to this user
  #   #@orders = Order.find_all_by_user_id(current_user[:id], :order => "id DESC")
  #   @orders = Order.joins(:user).where(users: {id: current_user[:id]}).order("id DESC")
  #   # lookup the quotes belonging to this user
  #   #@quotes = Quote.find_all_by_user_id(current_user[:id], :order => "id DESC")
  #   @quotes = Quote.joins(:user).where(users: {id: current_user[:id]}).order("id DESC")
  #   # lookup the purchases belonging to this user
  #   #@purchases = Purchase.find_all_by_user_id( current_user[:id], :order => "id DESC")
  #   @purchases = Purchase.joins(:user).where(users: {id: current_user[:id]}).order("id DESC")
  # else
  #   render 'new', notice: 'You tried to access an account that does not belong to you.'
  # end



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

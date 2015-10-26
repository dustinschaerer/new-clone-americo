class Admin::InhouseCustomersController < AdminController
  helper_method :sort_column, :sort_direction
  before_action :set_inhouse_customer, only: [:show, :edit, :update, :destroy]

  # GET /admin/inhouse_customers
  # GET /admin/inhouse_customers.json
  def index
      if params[:email] && params[:email] != ""
        @inhouse_customer = InhouseCustomer.find_by_email(params[:email])
        @inhouse_customers = InhouseCustomer.find_by_email(params[:email])
        @new_inhouse_customer = InhouseCustomer.new
        # raise 'inside params email is not nil'
        return
      elsif params[:email] && params[:email] == nil
        raise 'inside nil email params'
        @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)
        @new_inhouse_customer = InhouseCustomer.new
        return
      elsif params[:email] && params[:email] == ""
        # raise 'inside empty email string'
        @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)
        @new_inhouse_customer = InhouseCustomer.new
        return
      # elsif params[:sort] == nil
      #   @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)
      #   @new_inhouse_customer = InhouseCustomer.new
      else
        # raise 'inside else'
        @new_inhouse_customer = InhouseCustomer.new
        # @inhouse_customers = InhouseCustomer.order(sort_column.to_sym => sort_direction.to_sym).page(params[:page]).per(50)
        @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)

      end
    # elsif params[:inhouse_customer] && params[:inhouse_customer][:email]
    #   @inhouse_customers = InhouseCustomer.find_by_email(params[:inhouse_customer][:email])
    # elsif params[:sort] == nil
    #   @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)
    # elsif params[:email]
    #   @inhouse_customer = InhouseCustomer.find_by_email(params[:email])
    # else
    #   @inhouse_customers = InhouseCustomer.order(sort_column.to_sym => sort_direction.to_sym).page(params[:page]).per(50)
    # end
    # #@custies = InhouseCustomer.order(email: :asc)
    # @inhouse_customer = InhouseCustomer.new
    # #@search_inhouse_customer = InhouseCustomer.find_by_email(params[:email])

  end

  # GET /admin/inhouse_customers/1
  # GET /admin/inhouse_customers/1.json
  def show
    @inhouse_customer = InhouseCustomer.friendly.find(params[:id])
  end

  # GET /admin/inhouse_customers/new
  def new
    @inhouse_customer = InhouseCustomer.new
  end

  # GET /admin/inhouse_customers/1/edit
  def edit
  end

  # POST /admin/inhouse_customers
  # POST /admin/inhouse_customers.json
  def create
    @inhouse_customer = InhouseCustomer.new(inhouse_customer_params)

    exists = User.where(email: @inhouse_customer.email.chomp).exists?
    exists == true ? @inhouse_customer.is_user = true : @inhouse_customer.is_user = false
    respond_to do |format|
      if @inhouse_customer.save
        format.html { redirect_to action: 'index', notice: 'Inhouse customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inhouse_customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @inhouse_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/inhouse_customers/1
  # PATCH/PUT /admin/inhouse_customers/1.json
  def update
    respond_to do |format|
      if @inhouse_customer.update(inhouse_customer_params)
        format.html { redirect_to [:admin, @inhouse_customer], notice: 'Inhouse customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inhouse_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/inhouse_customers/1
  # DELETE /admin/inhouse_customers/1.json
  def destroy
    @inhouse_customer.destroy
    respond_to do |format|
      format.html { redirect_to admin_inhouse_customers_url, notice: 'Inhouse customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_groups_for
    inhouse_customers = InhouseCustomer.update_all({inhouse_group_id: params[:inhouse_group][:id]}, {id: params[:inhouse_customer_ids]})
    redirect_to admin_inhouse_customers_path(params)
  end

  def remove_from_group_for
    inhouse_customers = InhouseCustomer.update_all({inhouse_group_id: nil}, {id: params[:inhouse_customer_ids]})
    redirect_to admin_inhouse_groups_path(params)
  end

  def retrieve_for_autocomplete
    @search_inhouse_customers = InhouseCustomer.order(:email).where("email like ?", "%#{params[:term]}%")
    render json: @search_inhouse_customers.map(&:email)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inhouse_customer
      @inhouse_customer = InhouseCustomer.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inhouse_customer_params
      params.require(:inhouse_customer).permit(:email, :name, :date, :is_user)
    end

    def sort_column
      params[:sort] || "id"
    end

    def sort_direction
      params[:direction] || "asc"
    end

end

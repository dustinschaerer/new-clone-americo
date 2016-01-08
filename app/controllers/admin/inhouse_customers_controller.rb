class Admin::InhouseCustomersController < AdminController
  helper_method :sort_column, :sort_direction
  before_action :set_inhouse_customer, only: [:show, :edit, :update, :destroy]

  # GET /admin/inhouse_customers
  # GET /admin/inhouse_customers.json
  def index
    @new_inhouse_customer = InhouseCustomer.new
    # if params search is here, then this is a search request
    if params[:search] && params[:search].blank?
      @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)
      raise 'Inside params[:search] && params[:search].blank?'
      return
    elsif params[:search] && params[:search].present? && params[:email].present?
      @inhouse_customer = InhouseCustomer.find_by_email(params[:email])
      @inhouse_customers = InhouseCustomer.find_by_email(params[:email])?'
      return
    elsif params[:sort] == nil
      @inhouse_customers = InhouseCustomer.order("id DESC").page(params[:page]).per(50)
      return
    else
      @inhouse_customers = InhouseCustomer.order(sort_column.to_sym => sort_direction.to_sym).page(params[:page]).per(50)
      return
    end
  end

  # GET /admin/inhouse_customers/1
  # GET /admin/inhouse_customers/1.json
  def show
    @inhouse_customer = InhouseCustomer.find(params[:id])
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

  def import
    InhouseCustomer.import(params[:file])
    redirect_to admin_inhouse_customers_path, notice: "CSV file imported."
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inhouse_customer
      @inhouse_customer = InhouseCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inhouse_customer_params
      params.require(:inhouse_customer).permit(:email, :name, :date, :is_user, :subscribed,
        :file, :account_number, :contact)
    end

    def sort_column
      params[:sort] || "id"
    end

    def sort_direction
      params[:direction] || "asc"
    end

end

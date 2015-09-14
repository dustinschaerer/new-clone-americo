class Admin::ProspectsController < AdminController
  helper_method :sort_column, :sort_direction
  before_action :set_prospect, only: [:show, :destroy, :update, :edit]

  def index
    # @prospects = Prospect.order("id DESC").page(params[:page]).per(50)
    if params[:sort] == "prospect_group_name"
      # SIDE EFFECT this query does not show any prospects with unassigned  prospect groups
      @prospects = Prospect.joins(:prospect_group).references(:prospect_group).merge(ProspectGroup.order(:name => :asc)).page(params[:page]).per(100)
    elsif params[:sort] == "prospect_group_name_desc"
      # SIDE EFFECT this query does not show any prospects with unassigned  prospect groups
      @prospects = Prospect.joins(:prospect_group).references(:prospect_group).merge(ProspectGroup.order(:name => :desc)).page(params[:page]).per(100)
    else
      # raise (sort_column + " " + sort_direction)
      # @prospects = Prospect.order(params[:sort] + " " + params[:direction]).page(params[:page]).per(50)
      @prospects = Prospect.order(sort_column.to_sym => sort_direction.to_sym).page(params[:page]).per(50)
    end
    @prospect = Prospect.new
  end

  def show

  end

  def edit

  end

  def create
    @prospect = Prospect.new(prospect_params)
    email_validator = EmailValidator.new(@prospect.email)
    if email_validator.valid?
      exists = User.where(email: @prospect.email.chomp).exists?
      if exists == false
        respond_to do |format|
          if @prospect.save
            format.html { redirect_to action: 'index', notice: 'prospect was successfully created.' }
            format.json { render action: 'index', status: :created, location: @prospect }
          else
            format.html { render action: 'index' }
            format.json { render json: @prospect.errors, status: :unprocessable_entity }
          end
        end
      else
        this_user = User.find_by_email(@prospect.email.chomp)
        flash[:error] = "The email address entered is already a current user. You can see #{view_context.link_to this_user.email, admin_user_path(this_user)}'s user profile here.".html_safe
        redirect_to :back and return
      end
    else
      flash[:error] = "The email address upi entered is invalid. Please try again."
      redirect_to :back and return
    end
  end

  def update
    respond_to do |format|
      if @prospect.update(prospect_params)
        format.html { redirect_to admin_prospects_path, notice: 'Prospect was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @prospect.destroy
    respond_to do |format|
      format.html { redirect_to admin_prospects_url }
      format.json { head :no_content }
    end
  end

  def assign_groups_for
    prospects = Prospect.update_all({prospect_group_id: params[:prospect_group][:id]}, {id: params[:prospect_ids]})
    redirect_to admin_prospects_path(params)
  end

  def remove_from_group_for
    prospects = Prospect.update_all({prospect_group_id: nil}, {id: params[:prospect_ids]})
    redirect_to admin_prospect_groups_path(params)
  end

  def retrieve_for_autocomplete
    @prospects = Prospect.order(:email).where("email like ?", "%#{params[:term]}%")
    render json: @prospects.map(&:email)
  end

  def show_unassigned
    @prospects = Prospect.where("prospect_group_id IS NULL").page(params[:page]).per(100)
    @prospect = Prospect.new
    render :index
  end

  def show_assigned
    @prospects = Prospect.where("prospect_group_id IS NOT NULL").order("id DESC").page(params[:page]).per(50)
    @prospect = Prospect.new
    render :index
  end


  def unassign_all
    @prospects = Prospect.update_all(prospect_group_id: nil).order("id DESC").page(params[:page]).per(50)
    @prospect = Prospect.new
    render :index
  end


  private
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_params
      params.require(:prospect).permit(:id, :email, :unsubscribed, :validated,
        :date_joined_on, :name, :prospect_group_id, :active, :sort_direction, :sort_column)
    end

    def sort_column
      params[:sort] || "id"
    end

    def sort_direction
      params[:direction] || "asc"
    end

end

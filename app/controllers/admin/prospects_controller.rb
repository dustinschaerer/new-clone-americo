class Admin::ProspectsController < AdminController

  before_action :set_prospect, only: [:show, :destroy, :update]
  def index
    @prospects = Prospect.order("id DESC").page(params[:page]).per(50)
    @prospect = Prospect.new
    #@prospect_groups = Admin::ProspectGroup.all
  end

  def show

  end

  def create
    @prospect = Prospect.new(prospect_params)
    email_validator = EmailValidator.new(@prospect.email)
    if email_validator.valid?
      exists = User.where(email: @prospect.email.chomp).exists?
      if !exists
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
        flash[:notice] = "The email address entered is already a current user"
        redirect_to :back and return
      end
    else
      #this email was not valid, so do this...
      flash[:error] = "The email address upi entered is invalid. Please try again."
      redirect_to :back and return
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
    # prospects = Prospect.update( params[:prospect_ids], {prospect_group_id: params[:prospect_groups][:id]})
    prospects = Prospect.update_all({prospect_group_id: params[:prospect_group][:id]}, {id: params[:prospect_ids]})
    redirect_to admin_prospects_path(params)
  end

  def remove_from_group
    ### TODO ###
  end

  def retrieve_for_autocomplete
    @prospects = Prospect.order(:email).where("email like ?", "%#{params[:term]}%")
    render json: @prospects.map(&:email)
  end


  private
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_params
      params.require(:prospect).permit(:id, :email, :unsubscribed, :validated, :date_joined_on, :name, :prospect_group_id)
    end

end

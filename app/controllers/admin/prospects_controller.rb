class Admin::ProspectsController < AdminController
  helper_method :sort_column, :sort_direction
  before_action :set_prospect, only: [:show, :destroy, :update, :edit]

  def index
    if params[:sort] == nil
      @prospects = Prospect.order("id DESC").page(params[:page]).per(50)
    else
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
    @prospects = Prospect.update_all(prospect_group_id: nil)
    @prospect = Prospect.new
    redirect_to admin_prospects_path
  end

  def add_unsorted_prospects_into_new_groups
    # setup variables
    group_cutoff_number = 250
    unsorted_prospects = Prospect.where(prospect_group_id: nil).order(:id)
    last_autosorted_prospect_group = ProspectGroup.where("name like ?", "%Autosorted%").order(:name).last

    current_prospect_count = last_autosorted_prospect_group.prospects.count

    # raise current_prospect_count.inspect

    # DEBUG ######################################
    # raise last_autosorted_prospect_group.inspect
    # raise current_prospect_count.inspect
    # raise unsorted_prospects.inspect
    ##############################################

    # loop over unsorted unsorted_prospects
    unsorted_prospects.each do |prospect|
      # if the number of prospects in the last autosorted prospect group is 250  or less
      # Add unsorted prospects to the current last autosorted prospect group until it reached
      # the cutoff limit. Then crate a new cutoff autosorted group and add to it itll it's full.

      # unless this user is inactive, do...
      unless prospect.active == false

        if current_prospect_count <= group_cutoff_number
          prospect.prospect_group_id = last_autosorted_prospect_group.id
          prospect.save!

        # else if purchase user count is 251
        else
          # find or create by incremented new Autosorted Group #
          prospect_array = last_autosorted_prospect_group.name.reverse.split(" ", 2).map(&:reverse).reverse
          # increment the integer in the group name within the array, and join it back together
          prospect_array[1] = (prospect_array[1].to_i + 1).to_s
          prospect_record_string = prospect_array.join(" ")
          # find or create a new user group with the created string and with "kind" set to 'prospects'
          current_prospect_group = ProspectGroup.find_or_create_by(name: prospect_record_string, kind: "Prospects")

          # assign user_group for user
          prospect.prospect_group_id = current_prospect_group.id
          # reset counter to include this record
          prospect_user_count = 1
          prospect.save!
        end
      end
    end
    redirect_to admin_prospects_path
  end
  private
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_params
      params.require(:prospect).permit(:id, :email, :unsubscribed, :validated,
        :date_joined_on, :name, :prospect_group_id, :active, :sort_direction, :sort_column,
        :email_message_id, :last_sent_on)
    end

    def sort_column
      params[:sort] || "id"
    end

    def sort_direction
      params[:direction] || "asc"
    end

end

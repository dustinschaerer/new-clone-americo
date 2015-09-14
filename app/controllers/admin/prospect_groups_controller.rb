class Admin::ProspectGroupsController < AdminController
  before_action :set_prospect_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/prospect_groups
  # GET /admin/prospect_groups.json
  def index
    @prospect_groups = ProspectGroup.all
    @prospect_group = ProspectGroup.new
  end

  # GET /admin/prospect_groups/1
  # GET /admin/prospect_groups/1.json
  def show
  end

  # GET /admin/prospect_groups/new
  def new
    @prospect_group = ProspectGroup.new
  end

  # GET /admin/prospect_groups/1/edit
  def edit
  end

  # POST /admin/prospect_groups
  # POST /admin/prospect_groups.json
  def create
    @prospect_group = ProspectGroup.new(prospect_group_params)

    respond_to do |format|
      if @prospect_group.save
        format.html { redirect_to admin_prospect_groups_path, notice: 'Prospect group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prospect_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @prospect_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/prospect_groups/1
  # PATCH/PUT /admin/prospect_groups/1.json
  def update
    respond_to do |format|
      if @prospect_group.update(prospect_group_params)
        format.html { redirect_to admin_prospect_groups_path, notice: 'Prospect group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prospect_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/prospect_groups/1
  # DELETE /admin/prospect_groups/1.json
  def destroy
    @prospect_group.destroy
    respond_to do |format|
      format.html { redirect_to prospect_groups_url }
      format.json { head :no_content }
    end
  end

  def remove_from_group_for
    prospects = Prospect.update_all({prospect_group_id: nil}, {id: params[:prospect_ids]})
    redirect_to admin_prospect_groups_path(params)
  end

  def add_unsorted_prospects_into_new_groups
    # setup variables
    group_cutoff_number = 250
    unsorted_prospects = Prospect.where(prospect_group_id: nil).order(:id)
    last_autosorted_prospect_group = ProspectGroup.where("name like ?", "%Autosorted%").order(:name).last
    current_prospect_count = last_autosorted_prospect_group.prospects.count
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
          raise last_autosorted_prospect_group.inspect
          prospect.prospect_group_id = last_autosorted_prospect_group.id
          prospect.save!

        # else if purchase user count is 251
        else
          raise last_autosorted_prospect_group.inspect
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
    redirect_to admin_prospect_groups_path
  end

  def show_unassigned
    @prospects = Prospect.where("prospect_group = ?", nil).order(:id)
    # render
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prospect_group
      @prospect_group = ProspectGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_group_params
      params.require(:prospect_group).permit(:name, :email_message, :updated_at, :created_at)
    end
end

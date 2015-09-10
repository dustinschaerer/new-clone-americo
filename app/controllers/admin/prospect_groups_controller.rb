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

  def sort_prospects_into_default_groups

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

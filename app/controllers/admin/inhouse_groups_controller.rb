class Admin::InhouseGroupsController < AdminController
  before_action :set_inhouse_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/inhouse_groups
  # GET /admin/inhouse_groups.json
  def index
    @inhouse_groups = InhouseGroup.all
    @inhouse_group = InhouseGroup.new
  end

  # GET /admin/inhouse_groups/1
  # GET /admin/inhouse_groups/1.json
  def show

  end

  # GET /admin/inhouse_groups/new
  def new
    @inhouse_group = InhouseGroup.new
  end

  # GET /admin/inhouse_groups/1/edit
  def edit
  end

  # POST /admin/inhouse_groups
  # POST /admin/inhouse_groups.json
  def create
    @inhouse_group = InhouseGroup.new(inhouse_group_params)

    respond_to do |format|
      if @inhouse_group.save
        format.html { redirect_to [:admin, @inhouse_group], notice: 'Inhouse group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inhouse_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @inhouse_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/inhouse_groups/1
  # PATCH/PUT /admin/inhouse_groups/1.json
  def update
    respond_to do |format|
      if @inhouse_group.update(inhouse_group_params)
        format.html { redirect_to [:admin, @inhouse_group], notice: 'Inhouse group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inhouse_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/inhouse_groups/1
  # DELETE /admin/inhouse_groups/1.json
  def destroy
    @inhouse_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_inhouse_groups_url, notice: 'Inhouse group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inhouse_group
      @inhouse_group = InhouseGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inhouse_group_params
      params.require(:inhouse_group).permit(:name, :email_message_id, :last_sent_on)
    end
end

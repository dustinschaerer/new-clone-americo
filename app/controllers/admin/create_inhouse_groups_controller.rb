class Admin::CreateInhouseGroupsController < ApplicationController
  before_action :set_create_inhouse_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/create_inhouse_groups
  # GET /admin/create_inhouse_groups.json
  def index
    @create_inhouse_groups = CreateInhouseGroup.all
  end

  # GET /admin/create_inhouse_groups/1
  # GET /admin/create_inhouse_groups/1.json
  def show
  end

  # GET /admin/create_inhouse_groups/new
  def new
    @create_inhouse_group = CreateInhouseGroup.new
  end

  # GET /admin/create_inhouse_groups/1/edit
  def edit
  end

  # POST /admin/create_inhouse_groups
  # POST /admin/create_inhouse_groups.json
  def create
    @create_inhouse_group = CreateInhouseGroup.new(create_inhouse_group_params)

    respond_to do |format|
      if @create_inhouse_group.save
        format.html { redirect_to [:admin, @create_inhouse_group], notice: 'Create inhouse group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @create_inhouse_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @create_inhouse_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/create_inhouse_groups/1
  # PATCH/PUT /admin/create_inhouse_groups/1.json
  def update
    respond_to do |format|
      if @create_inhouse_group.update(create_inhouse_group_params)
        format.html { redirect_to [:admin, @create_inhouse_group], notice: 'Create inhouse group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @create_inhouse_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/create_inhouse_groups/1
  # DELETE /admin/create_inhouse_groups/1.json
  def destroy
    @create_inhouse_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_create_inhouse_groups_url, notice: 'Create inhouse group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_create_inhouse_group
      @create_inhouse_group = CreateInhouseGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_inhouse_group_params
      params.require(:create_inhouse_group).permit(:name, :email_message_id, :last_sent_on)
    end
end

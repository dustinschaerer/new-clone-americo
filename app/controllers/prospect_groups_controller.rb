class ProspectGroupsController < ApplicationController
  before_action :set_prospect_group, only: [:show, :edit, :update, :destroy]

  # GET /prospect_groups
  # GET /prospect_groups.json
  def index
    @prospect_groups = ProspectGroup.all
  end

  # GET /prospect_groups/1
  # GET /prospect_groups/1.json
  def show
  end

  # GET /prospect_groups/new
  def new
    @prospect_group = ProspectGroup.new
  end

  # GET /prospect_groups/1/edit
  def edit
  end

  # POST /prospect_groups
  # POST /prospect_groups.json
  def create
    @prospect_group = ProspectGroup.new(prospect_group_params)

    respond_to do |format|
      if @prospect_group.save
        format.html { redirect_to @prospect_group, notice: 'Prospect group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prospect_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @prospect_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prospect_groups/1
  # PATCH/PUT /prospect_groups/1.json
  def update
    respond_to do |format|
      if @prospect_group.update(prospect_group_params)
        format.html { redirect_to @prospect_group, notice: 'Prospect group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prospect_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prospect_groups/1
  # DELETE /prospect_groups/1.json
  def destroy
    @prospect_group.destroy
    respond_to do |format|
      format.html { redirect_to prospect_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prospect_group
      @prospect_group = ProspectGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_group_params
      params.require(:prospect_group).permit(:name, :email_message_id, :last_sent_on)
    end
end

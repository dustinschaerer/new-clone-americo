class Admin::MandrilTagsController < ApplicationController
  before_action :set_mandril_tag, only: [:show, :edit, :update, :destroy]

  # GET /admin/mandril_tags
  # GET /admin/mandril_tags.json
  def index
    @mandril_tags = MandrilTag.all
  end

  # GET /admin/mandril_tags/1
  # GET /admin/mandril_tags/1.json
  def show
  end

  # GET /admin/mandril_tags/new
  def new
    @mandril_tag = MandrilTag.new
  end

  # GET /admin/mandril_tags/1/edit
  def edit
  end

  # POST /admin/mandril_tags
  # POST /admin/mandril_tags.json
  def create
    @mandril_tag = MandrilTag.new(mandril_tag_params)

    respond_to do |format|
      if @mandril_tag.save
        format.html { redirect_to [:admin, @mandril_tag], notice: 'Mandril tag was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mandril_tag }
      else
        format.html { render action: 'new' }
        format.json { render json: @mandril_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/mandril_tags/1
  # PATCH/PUT /admin/mandril_tags/1.json
  def update
    respond_to do |format|
      if @mandril_tag.update(mandril_tag_params)
        format.html { redirect_to [:admin, @mandril_tag], notice: 'Mandril tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mandril_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mandril_tags/1
  # DELETE /admin/mandril_tags/1.json
  def destroy
    @mandril_tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_mandril_tags_url, notice: 'Mandril tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mandril_tag
      @mandril_tag = MandrilTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mandril_tag_params
      params.require(:mandril_tag).permit(:title)
    end
end

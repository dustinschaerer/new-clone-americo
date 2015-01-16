class Admin::LinesController < AdminController

  before_action :set_line, only: [:update]


  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        #format.json { head :no_content }
        format.json { respond_with_bip(@line) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@line) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params.require(:line).permit(:id, :quote_product_id, :length, :width, :height, :cover_id, :series_id, :color_id, :shape_id, :umbrella, :velcro, :yards, :size_id, :quantity, :price, :id, :finish, :laminate_side)
    end
end

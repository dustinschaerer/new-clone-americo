class Admin::QuotesController < AdminController

  before_action :set_quote, only: [:show, :edit, :update, :destroy, :recalculate, :send_priced_email, :send_question_email]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all.order("id DESC").includes(:user).page(params[:page]).per(50)
  end

  def show
  end

  def edit
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to quote_path(@quote), notice: 'Quote was successfully updated.' }
        #format.json { head :no_content }
        format.json { respond_with_bip(@quote) }
      else
        format.html { render action: 'edit' }
        #format.json { render json: @quote.errors, status: :unprocessable_entity }
        format.json { respond_with_bip(@quote) }
      end
    end
  end

  def destroy
  end

  def recalculate
    #@quote = Quote.find(params[:id])
    @quote.calculate_subtotal
    @quote.calculate_sales_tax
    @quote.calculate_total
    if @quote.save!
      logger.debug "THE TOALS FOR QUOTE #{@quote.id} have been recalculated and successfully saved."
      redirect_to [:admin, @quote], :notice => "Totals have been recalculated."
    else
      logger.debug "NOT SAVED. The totals for Quote #{@quote.id} have been recalculated, but not successfully saved."
      render :back, :notice => "ERROR: Could not save updated quote"
    end
  end

  def send_priced_email
    #@quote = Quote.find(params[:id])
    @current_user_id = @quote.user_id
    @current_user = User.find(@current_user_id)
    QuoteNotifier.priced(@quote, @current_user).deliver
    @quote.status = "Priced"
    if @quote.save!
      logger.debug "Priced Email message sent to customer."
      redirect_to [:admin, @quote], :notice => "Priced Email message sent to customer."
    else
      render :back, :notice => "ERROR: Could not update Quote Status to Priced."
    end
  end

  def send_question_email
    @current_user_id = @quote.user_id
    @current_user = User.find(@current_user_id)
    if QuoteNotifier.question(@quote, @current_user).deliver
      redirect_to [:admin, @quote], :notice => "Question or Comment Email message has been successfully sent to customer."
    else
      render :back, :notice => "ERROR: Could not deliver email message."
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:user_id, :firstname, :lastname, :company, :email, :status, :telephone, :contactby, :ship_street_address, :ship_city, :ship_state, :ship_zipcode, :ship_country, :subtotal, :shipping, :sales_tax, :total, :pay_type, :id, :tax_id, :question,
        lines_attributes: [:id, :price, :quantity])
    end
end

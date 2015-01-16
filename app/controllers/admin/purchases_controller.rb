class Admin::PurchasesController < AdminController

  before_action :set_purchase, only: [:show, :edit, :update, :destroy, :send_question_email, :send_shipped_email ]

  # GET /purchases
  # GET /purchsases.json
  def index
    @purchases = Purchase.all.order("id DESC").includes(:user).page(params[:page]).per(20)
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def send_question_email
    @current_user_id = @purchase.user_id
    @current_user = User.find(@current_user_id)
    if PurchaseNotifier.question(@purchase, @current_user).deliver
      redirect_to admin_purchases_path, :notice => "Question or Comment Email message has been successfully sent to customer."
    else
      render :back, :notice => "ERROR: Could not deliver email message."
    end
  end

  def send_shipped_email
    @current_user_id = @purchase.user_id
    @current_user = User.find(@current_user_id)
    PurchaseNotifier.shipped(@purchase, @current_user).deliver
    if (@purchase.status == "Shipped")
      redirect_to admin_purchase_path(@purchase), {:notice => "WARNING: EMAIL MESSAGE SENT TO CUSTOMER AGAIN - Your Purchase has Shipped Email was re-sent to #{@current_user.email}."}
    else
      @purchase.status = "Shipped"
      if @purchase.save
        redirect_to admin_purchase_path(@purchase), {:notice => "Purchase ##{@purchase.id} Shipped Email has been sent to #{@current_user.email}."}
      else
        redirect_to admin_purchase_path(@purchase), {:notice => "Purchase Status could not be saved. Please review the status and try again."}
      end
    end
  end


   private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:user_id, :firstname, :lastname, :telephone,
        :contactby, :ship_street_address, :ship_city, :ship_state, :ship_zipcode,
        :ship_country, :pay_firstname, :pay_lastname, :pay_company, :pay_telephone,
        :pay_status, :status, :pay_street_address, :pay_city, :pay_state, :pay_zipcode,
        :pay_country, :subtotal, :shipping, :sales_tax, :total, :pay_type, :card_type,
        :card_expires_on, :state, :ip_address, :amount, :user, :company, :card_number,
        :card_verification, :month, :year, :email, :quote_id, :tax_id, :question,
        quotes_attributes: [:status, :id], lines_attributes: [:id, :price, :quantity])
    end
end




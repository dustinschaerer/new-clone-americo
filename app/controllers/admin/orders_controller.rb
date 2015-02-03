class Admin::OrdersController < AdminController
  before_action :authenticate_admin_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :send_question_email, :send_shipped_email]
  after_action :reset_current_color, only: [:update]

  #has_scope :pending

  # GET /orders
  # GET /orders.json
  def index
    if (params[:status] == "Submitted")
      @orders = Order.pending.order("id DESC").includes(:user).page(params[:page]).per(50)
    else
      @orders = Order.all.order("id DESC").includes(:user).page(params[:page]).per(50)
    end
    #@orders = Order.all.where(nil)
    #@orders = @orders.pending if params[:status].present?
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/1/edit
  def edit
     if (@order.user_id) == (current_user.id)
      # only edit this quote if it belongs to the signed in user
    else
      redirect_to root_url, notice: "You must sign in to edit your order."
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
#        format.json { head :no_content }
        format.json { respond_with_bip(@order) }

      else
        format.html { render action: 'edit' }
#        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.json { respond_with_bip(@order) }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def send_question_email
    @current_user_id = @order.user_id
    @current_user = User.find(@current_user_id)
    if OrderNotifier.question(@order, @current_user).deliver
      redirect_to admin_orders_path, :notice => "Question or Comment Email message has been successfully sent to customer."
    else
      render :back, :notice => "ERROR: Could not deliver email message."
    end
  end

  def send_shipped_email
    @current_user_id = @order.user_id
    @current_user = User.find(@current_user_id)
    OrderNotifier.shipped(@order, @current_user).deliver
    if (@order.status == "Shipped")
      redirect_to admin_order_path(@order), {:notice => "WARNING: EMAIL MESSAGE SENT TO CUSTOMER AGAIN - Your order has Shipped Email was re-sent to #{@current_user.email}."}
    else
      @order.status = "Shipped"
      if @order.save
        redirect_to admin_order_path, {:notice => "order ##{@order.id} Shipped Email has been sent to #{@current_user.email}."}
      else
        redirect_to admin_order_path(@order), {:notice => "Order Status could not be saved. Please review the status and try again."}
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:firstname, :lastname, :company, :street_address, :city, :state, :zipcode, :country, :telephone, :email, :user_id, :status, :question)
    end

    def reset_current_color
      if (@order.status == "Submitted")
        return :warn
      elsif (@order.status == "Shipped")
        return :ok
      elsif (@order.status == "Offline Purchased")
        return :offline_purchased
      elsif (@order.status == "Purchased")
        return :error
      end
    end


end

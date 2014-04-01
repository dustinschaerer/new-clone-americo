class PurchasesController < ApplicationController
  include CurrentQuotecart
  include CurrentCart
  before_action :set_quotecart
  before_action :set_cart
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @quote = Quote.find(params[:quote_id])
    @purchase.firstname = @quote.firstname
    @purchase.lastname = @quote.lastname
    @purchase.telephone = @quote.telephone
    @purchase.user_id = @quote.user_id
    @purchase.contactby = @quote.contactby
    @purchase.ship_street_address = @quote.ship_street_address
    @purchase.ship_city = @quote.ship_city
    @purchase.ship_state = @quote.ship_state
    @purchase.ship_zipcode = @quote.ship_zipcode
    @purchase.ship_country = @quote.ship_country
    @purchase.subtotal= @quote.subtotal
    @purchase.shipping = @quote.shipping
    @purchase.sales_tax = @quote.sales_tax
    @purchase.total = @quote.total
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    if (params[:checkbox_use_same_address] == true)
      @purchase.pay_firstname = @purchase.firstname 
      @purchase.pay_lastname = @purchase.lastname 
      @purchase.pay_company = @purchase.company 
      @purchase.pay_telephone = @purchase.telephone
      @purchase.pay_street_address = @purchase.ship_street_address 
      @purchase.pay_city = @purchase.ship_city 
      @purchase.pay_zipcode = @purchase.ship_zipcode
      @purchase.pay_state = @purchase.ship_state
      @purchase.pay_country = @purchase.ship_country
    end

    @purchase = Purchase.new(purchase_params)
    
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render action: 'show', status: :created, location: @purchase }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:user_id, :firstname, :lastname, :telephone, :contactby, :ship_street_address, :ship_city, :ship_state, :ship_zipcode, :ship_country, :pay_street_address, :pay_city, :pay_state, :pay_zipcode, :pay_country, :subtotal, :shipping, :sales_tax, :total, :pay_type)
    end
end

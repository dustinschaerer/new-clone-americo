class InhouseCustomersController < ApplicationController
  before_action :set_inhouse_customer, only: [:show]

  # GET /inhouse_customers/1?unsubcribe_from_emails=1
  def show
    @unsubscribe = params[:unsubscribe_from_emails]
    # if @unsubscribe == "1"
    if @unsubscribe != nil
      @inhouse_customer.subscribed = false
      respond_to do |format|
        if @inhouse_customer.save!
          format.html { redirect_to root_url, notice: 'You have been unsubscribed from our mailing list.' }
        else
          format.html { redirect_to root_url notice: 'There was an error removing you from our mailing list.' }
        end
      end
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inhouse_customer
      @inhouse_customer = InhouseCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inhouse_customer_params
      params.require(:inhouse_customer).permit(:id, :email, :subscribed, :unsubscribed, :validated,
        :date_joined_on, :name, :inhouse_customer_group_id, :active)
    end
end

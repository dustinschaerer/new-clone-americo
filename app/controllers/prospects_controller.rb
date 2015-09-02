class ProspectsController < ApplicationController
  before_action :set_prospect, only: [:show]

  # GET /prospects/1?unsubcribe_from_emails=true
  def show
    @unsubscribe = params[:unsubscribe_from_emails]
    if @unsubscribe == "1"
      @prospect.subscribed = false
      respond_to do |format|
        if @prospect.save!
          format.html { redirect_to root_url, notice: 'You have been unsubscribed from our mailing list.' }
        else
          format.html { redirect_to root_url }
        end
      end
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_params
      params.require(:prospect).permit(:id, :email, :unsubscribed, :validated,
        :date_joined_on, :name, :prospect_group_id, :active)
    end
end

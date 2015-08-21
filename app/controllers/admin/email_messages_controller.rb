class Admin::EmailMessagesController < AdminController
  before_action :set_email_message, only: [:show, :edit, :update, :destroy]

  def index
    @admin_email_messages = EmailMessage.all
  end

  def new
    @admin_email_message = EmailMessage.new
  end

  def show
    @admin_email_message = EmailMessage.find(params[:id])
  end

  def edit
    @admin_email_message = EmailMessage.find(params[:id])
  end

  def email_manager
    @admin_email_messages = EmailMessage.all
    @prospects = Prospect.order("id DESC").page(params[:page]).per(50)
    @prospect_groups = ProspectGroup.all
  end

  def send_email_to_prospects
    @admin_email_message = EmailMessage.find(params[:email_message][:id])
    @prospect_groups = ProspectGroup.find(params[:prospect_group][:id])
  end


  private

    def set_email_message
      @admin_email_message = EmailMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_message_params
      params.require(:admin_email_message).permit(:subject, :headers, :content, :mandril_tags, :template)
    end

end

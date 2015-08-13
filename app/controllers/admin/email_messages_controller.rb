class Admin::EmailMessagesController < AdminController

  def index
    @admin_email_messages = EmailMessage.all
  end



  def show
    @admin_email_message = EmailMessage.find(params[:id])
  end


  private

    def set_email_message
      @admin_email_message = EmailMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_message_params
      params.require(:email_message).permit(:subject, :headers, :content, :mandril_tags, :template)
    end

end

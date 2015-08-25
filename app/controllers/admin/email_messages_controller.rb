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
    @prospect_groups = ProspectGroup.all
    @user_groups = UserGroup.all
    @user = User.all
    @prospect = Prospect.all
    @sent_email = SentEmail.new

  end

  def send_email_to_prospects
    @admin_email_message = EmailMessage.find(params[:email_message][:id])
    @prospect_groups = ProspectGroup.find(params[:prospect_group][:id])
  end

  def send_email_to_users
    @admin_email_message = EmailMessage.find(params[:email_message][:id])
    @user_groups = UserGroup.find(params[:user_group][:id])
    #####################################################################
    # Take the submitted parameters and build necessary fields
    # Calculate actual recipients and count recipients
    #####################################################################


    ####################################################################
    # record send action in email manager setting send datetime, actual
    # recipients hash, recipient_count, and user_group
    ####################################################################
    actual_recipient_hash {}
    @user_groups.users.each do |user|
      actual_recipient_hash[ user.class.to_sym => { user.id.to_sym => "user.email"} ]
    end
    raise actual_recipient_hash.inspect
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

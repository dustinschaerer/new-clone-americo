class Admin::EmailMessagesController < AdminController
  before_action :set_email_message, only: [:edit, :update]

  def index
    @admin_email_messages = EmailMessage.all.order(:id)
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

  def create
    @admin_email_message = EmailMessage.new(email_message_params)

    respond_to do |format|
      if @admin_email_message.save
        format.html { redirect_to [:admin, @admin_email_message], notice: 'Email message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_email_message }
      else
        format.html { render action: 'new' }
        format.json { render json: [:admin, @admin_email_message].errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_email_message.update(email_message_params)
        format.html { redirect_to [:admin, @admin_email_message], notice: 'Email message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: [:admin, @admin_email_message].errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_email_message = EmailMessage.find(params[:id])
    @admin_email_message.destroy
    respond_to do |format|
      format.html { redirect_to admin_email_messages_url }
      format.json { head :no_content }
    end
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
    actual_recipient_hash = {}
    @user_groups.users.each do |user|
      actual_recipient_hash[ user.class.to_sym => { user.id.to_sym => "user.email"} ]
    end
    raise actual_recipient_hash.inspect
  end

  def preview
    @admin_email_message = EmailMessage.find(params[:id])
    render layout: false
  end

  private

    def set_email_message
      @admin_email_message = EmailMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_message_params
      params.require(:email_message).permit(:id, :subject, :headers, :content, :text_content, :mandril_tag, :template, :mailer_method)
    end

end

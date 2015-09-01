class Admin::SentEmailsController < AdminController
  before_action :set_sent_email, only: [:show, :edit, :update, :destroy]

  # GET /admin/sent_emails
  # GET /admin/sent_emails.json
  def index
    @sent_emails = SentEmail.all
  end

  # GET /admin/sent_emails/1
  # GET /admin/sent_emails/1.json
  def show
  end

  # GET /admin/sent_emails/new
  def new
    @sent_email = SentEmail.new
    @sent_emails = SentEmail.all
    @admin_email_messages = EmailMessage.all
    @prospect_groups = ProspectGroup.all
    @user_groups = UserGroup.all
    @users = User.all
    @prospects = Prospect.all
  end

  # GET /admin/sent_emails/1/edit
  def edit
  end

  # POST /admin/sent_emails
  # POST /admin/sent_emails.json
  def create
    actual_recipients_hash = {}
    recipient_count = 0
    @sent_email = SentEmail.new(sent_email_params)
    addy = params[:sent_email][:user_email]

    if params[:sent_email][:user_email]
      this_user = User.find_by_email(params[:sent_email][:user_email])
      @sent_email.sendable_id = this_user.id
    elsif params[:sent_email][:prospect_email]
      this_prospect = Prospect.find_by_email(params[:sent_email][:prospect_email])
      @sent_email.sendable_id = this_prospect.id
    end

    @list_entity = @sent_email.sendable_type.camelize.constantize.find(@sent_email.sendable_id)

    if @sent_email.sendable_type == "user_group"
      @list_entity.users.each do |user|
        recipient_count += 1
        actual_recipients_hash["#{user.email}"] = { user.id => "user"}
        email_to_send = EmailMessage.find(@sent_email.email_message_id)
        if email_to_send.mailer_method == "dynamic_message"
          EmailMessageNotifier.send(email_to_send.mailer_method, user, email_to_send).deliver
        else
          EmailMessageNotifier.send(email_to_send.mailer_method, user, email_to_send).deliver
        end
      end
    elsif @sent_email.sendable_type == "prospect_group"
      # extract users class method
      @list_entity.prospects.each do |prospect|
        if prospect.active == true && prospect.unsubscribed == false
          recipient_count += 1
          actual_recipients_hash["#{prospect.email}"] = { prospect.id => "prospect"}
          email_to_send = EmailMessage.find(@sent_email.email_message_id)
          if email_to_send.mailer_method == "dynamic_message"
            EmailMessageNotifier.send(email_to_send.mailer_method, prospect, email_to_send).deliver
          else
            EmailMessageNotifier.send(email_to_send.mailer_method, prospect, email_to_send).deliver
          end
        end
      end
    elsif @sent_email.sendable_type == "user"
      # @list_entity # is a user object
      recipient_count += 1
      actual_recipients_hash["#{@list_entity.email}"] = { @list_entity.id => "user"}
      email_to_send = EmailMessage.find(@sent_email.email_message_id)
      if email_to_send.mailer_method == "dynamic_message"
        EmailMessageNotifier.send(email_to_send.mailer_method, @list_entity, email_to_send).deliver
      else
        EmailMessageNotifier.send(email_to_send.mailer_method, @list_entity, email_to_send).deliver
      end
    elsif @sent_email.sendable_type == "prospect"
      if @list_entity.active == true && !@list_entity.unsubscribed == false
        # @list_entity #is a prospect object
        recipient_count += 1
        actual_recipients_hash["#{@list_entity.email}"] = { @list_entity.id => "prospect"}
        email_to_send = EmailMessage.find(@sent_email.email_message_id)
        if email_to_send.mailer_method == "dynamic_message"
          EmailMessageNotifier.send(email_to_send.mailer_method, @list_entity, email_to_send).deliver
        else
          EmailMessageNotifier.send(email_to_send.mailer_method, @list_entity, email_to_send).deliver
        end
      end
    end

    @sent_email.actual_recipients = actual_recipients_hash
    @sent_email.recipient_count = recipient_count

    respond_to do |format|
      if @sent_email.save
        format.html { redirect_to [:admin, @sent_email], notice: 'Sent email was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sent_email }
      else
        format.html { render action: 'new' }
        format.json { render json: @sent_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/sent_emails/1
  # PATCH/PUT /admin/sent_emails/1.json
  def update
    respond_to do |format|
      if @sent_email.update(sent_email_params)
        format.html { redirect_to [:admin, @sent_email], notice: 'Sent email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sent_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sent_emails/1
  # DELETE /admin/sent_emails/1.json
  def destroy
    @sent_email.destroy
    respond_to do |format|
      format.html { redirect_to admin_sent_emails_url, notice: 'Sent email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sent_email
      @sent_email = SentEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sent_email_params
      params.require(:sent_email).permit(:email_message_id, :sendable_id, :sendable_type, :actual_recipients,
        :recipient_count, :sent_at, :user_name, :sendable_name, :user_email, :user_id, :prospect_email)
    end
end

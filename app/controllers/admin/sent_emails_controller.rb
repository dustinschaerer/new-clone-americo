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
    @admin_email_messages = EmailMessage.all
    @prospect_groups = ProspectGroup.all
    @user_groups = UserGroup.all
    @user = User.all
    @prospect = Prospect.all
  end

  # GET /admin/sent_emails/1/edit
  def edit
  end

  # POST /admin/sent_emails
  # POST /admin/sent_emails.json
  def create
    @sent_email = SentEmail.new(sent_email_params)

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
      params.require(:sent_email).permit(:email_message_id, :sendable_id, :sendable_type, :actual_recipients, :recipient_count, :sent_at)
    end
end

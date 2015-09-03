class EmailMessagesController < AdminController
  before_action :set_email_message, only: [:show, :edit, :update, :destroy]

  # GET /email_messages
  # GET /email_messages.json
  def index
    @email_messages = EmailMessage.all
  end

  # GET /email_messages/1
  # GET /email_messages/1.json
  def show
  end

  # GET /email_messages/new
  def new
    @email_message = EmailMessage.new
  end

  # GET /email_messages/1/edit
  def edit

  end

  # POST /email_messages
  # POST /email_messages.json
  def create
    @email_message = EmailMessage.new(email_message_params)

    respond_to do |format|
      if @email_message.save
        format.html { redirect_to @email_message, notice: 'Email message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @email_message }
      else
        format.html { render action: 'new' }
        format.json { render json: @email_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_messages/1
  # PATCH/PUT /email_messages/1.json
  def update
    respond_to do |format|
      if @email_message.update(email_message_params)
        format.html { redirect_to @email_message, notice: 'Email message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @email_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_messages/1
  # DELETE /email_messages/1.json
  def destroy
    @email_message.destroy
    respond_to do |format|
      format.html { redirect_to email_messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_message
      @email_message = EmailMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_message_params
      params.require(:email_message).permit(:subject, :headers, :content, :mandril_tags, :template)
    end
end

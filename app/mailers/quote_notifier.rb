class QuoteNotifier < ActionMailer::Base
  default from: 'ken@americo-inc.com'

  def received(quote, current_user)
    @quote = quote
    @current_user = current_user
    mail to: quote.email, subject: 'Americo Quote Confirmation'
  end

  def priced(quote)
    @quote = quote
    mail to: @quote.email, subject: 'Your Pricing on your Americo Quote'
  end

  # def priced_new(quote)
  #   @quote = quote
  #   mail to: ["dustinschaerer@gmail.com", "ken@americo-inc.com"], subject: 'Your Pricing on your Americo Quote'
  # end

  def question(quote, current_user)
    @quote = quote
    @current_user = current_user
    mail to: @quote.email, subject: 'Question about your Americo Quote'
  end

  # def quote_question_new(quote, user)
  #   @quote = quote
  #   @current_user = user
  #   # mail to: quote.email, subject: 'Question about your Americo Quote'
  #   mail to: ["dustinschaerer@gmail.com", "ken@americo-inc.com"], subject: 'Question about your Americo Quote'
  # end

  def notify_admin(quote)
    @quote = quote
    mail to: "ken@americo-inc.com", subject: 'New Quote received on Americo Dashboard'
  end

  def quote_followup(quote)
    @quote = quote
    @user = @quote.user_id
    mail to: quote.email, subject: 'Your Americo Quote is Ready for Purchase'
  end

  # def quote_followup_detail(quote)
  #   @quote = quote
  #   @user = @quote.user_id
  #   # mail to: quote.email, subject: 'Americo Quote is Ready for Purchase'
  #   mail to: ["dustinschaerer@gmail.com", "ken@americo-inc.com"], subject: 'Americo Quote is Ready for Purchase'
  # end

end
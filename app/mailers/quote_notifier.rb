class QuoteNotifier < ActionMailer::Base
  default from: 'ken@americo-inc.com'

  def received(quote, current_user)
    @quote = quote
    @current_user = current_user
    mail to: quote.email, subject: 'Americo Quote Confirmation'
  end

  def priced(quote, current_user)
    @quote = quote
    @current_user = current_user
    mail to: quote.email, subject: 'Pricing Complete on Americo Quote'
  end

  def priced_new(quote)
    @quote = quote
    @quote.lines.each do |line|
      # line.color_image_url
      # attachments.inline['patch.png'] = File.read('path/to/image.png')
      attachments.inline[File.basename(line.color_image_url)] = File.read(line.color_image_url)
    end
    mail to: "dustinschaerer@gmail.com", subject: 'Pricing Complete on Americo Quote'
  end

  def question(quote, current_user)
    @quote = quote
    @current_user = current_user
    mail to: quote.email, subject: 'Question about your Americo Quote'
  end

  def notify_admin(quote)
    @quote = quote
    mail to: "ken@americo-inc.com", subject: 'New Quote received on Americo Dashboard'
  end

  def quote_followup(quote)
    @quote = quote
    @user = @quote.user_id
    mail to: quote.email, subject: 'Americo Quote Follow Up'
  end

  def quote_followup_detail(quote)
    @quote = quote
    @user = @quote.user_id
    mail to: quote.email, subject: 'Americo Quote Follow Up Detail'
  end

end
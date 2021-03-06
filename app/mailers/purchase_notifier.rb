class PurchaseNotifier < ActionMailer::Base
  default from: 'ken@americo-inc.com'

  def confirmation(purchase, current_user)
    @purchase = purchase
    @current_user = current_user
    mail to: purchase.email, subject: 'Americo Purchase Confirmation'
  end

  def shipped(purchase, current_user)
    @purchase = purchase
    @current_user = current_user
    mail to: purchase.email, subject: 'Americo Purchase has Shipped'
  end

  def question(purchase, current_user)
    @purchase = purchase
    @current_user = current_user
    mail to: purchase.email, subject: 'Question about your Americo Purchase'
  end

  def notify_admin(purchase)
    @purchase = purchase
    mail to: "ken@americo-inc.com", subject: 'New Purchase received on Americo Dashboard'
  end
end

class OrderNotifier < ActionMailer::Base
  default from: 'ken@americo-inc.com'

  def received(order)
    @order = order
    mail to: order.email, subject: 'Americo Swatch Order Confirmation'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Americo Swatch Order Shipped'
  end

  def question(order, current_user)
    @order = order
    @current_user = current_user
    mail to: order.email, subject: "Response needed to ship Americo Order ##{@order.id}"
  end

  def notify_admin(order)
    @order = order
    mail to: 'ken@americo-inc.com', subject: 'New Order received on Americo Dashboard'
  end

  def order_followup(order)
    @order = order
    mail to: order.email, subject: 'Americo Swatch/Catalog Follow Up'
  end

end
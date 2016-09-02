class Admin::DashboardController < AdminController

  before_action :authenticate_admin_user!

  def index
    @new_users =  User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @users_last_month =  User.created_between(1.month.ago.beginning_of_month.beginning_of_day, 1.month.ago.end_of_month.end_of_day)
    @pending_orders = Order.all.where(status: "Submitted")
    @pending_quotes = Quote.pending
    @pending_purchases = Purchase.all.where(status: "Purchased")
    @orders = Order.all.order(id: :desc).limit(10)
    @quotes = Quote.all.order(id: :desc).limit(10)
    @purchases = Purchase.all.order(id: :desc).limit(10)
    @orders_this_month = Order.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @orders_last_month = Order.created_between(1.month.ago.beginning_of_month.beginning_of_day, 1.month.ago.end_of_month.end_of_day )
    @orders_2_months_ago = Order.created_between(2.months.ago.beginning_of_month.beginning_of_day, 2.months.ago.end_of_month.end_of_day)
    @quotes_this_month = Quote.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @quotes_last_month = Quote.created_between(1.month.ago.beginning_of_month.beginning_of_day, 1.month.ago.end_of_month.end_of_day)
    @purchases_this_month = Purchase.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @purchases_last_month = Purchase.created_between(1.month.ago.beginning_of_month.beginning_of_day, 1.month.ago.end_of_month.end_of_day)
  end

  def charts
    @new_users =  User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @new_orders = Order.all.where(status: "Submitted")
    @new_purchases = Purchase.all.where(status: "Purchased")
    @new_quotes = Quote.all.where(status: "Submitted")

    @orders = Order.all.order(id: :desc).limit(10)
    @quotes = Quote.all.order(id: :desc).limit(10)
    @purchases = Purchase.all.order(id: :desc).limit(10)

    @orders_this_month = Order.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @quotes_this_month = Quote.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @purchases_this_month = Purchase.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
  end

  def geocharts
    @new_users =  User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @new_orders = Order.all.where(status: "Submitted")
    @new_purchases = Purchase.all.where(status: "Purchased")
    @new_quotes = Quote.all.where(status: "Submitted")
    @orders = Order.all.order(id: :desc).limit(10)
    @quotes = Quote.all.order(id: :desc).limit(10)
    @purchases = Purchase.all.order(id: :desc).limit(10)
  end

  def single
    @new_users =  User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @new_orders = Order.all.where(status: "Submitted")
    @new_purchases = Purchase.all.where(status: "Purchased")
    @new_quotes = Quote.all.where(status: "Submitted")
    @orders = Order.all.order(id: :desc).limit(10)
    @quotes = Quote.all.order(id: :desc).limit(10)
    @purchases = Purchase.all.order(id: :desc).limit(10)
  end

  def chartsuey
    @new_users =  User.created_between(Time.zone.now.beginning_of_month.beginning_of_day, Time.zone.now.end_of_month.end_of_day)
    @new_orders = Order.all.where(status: "Submitted")
    @new_purchases = Purchase.all.where(status: "Purchased")
    @new_quotes = Quote.all.where(status: "Submitted")
    @orders = Order.all.order(id: :desc).limit(10)
    @quotes = Quote.all.order(id: :desc).limit(10)
    @purchases = Purchase.all.order(id: :desc).limit(10)
  end


  def user_traffic
  end

  def visits
  end

  def visitor_stats
  end

end


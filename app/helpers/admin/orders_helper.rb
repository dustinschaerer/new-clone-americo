module Admin::OrdersHelper
  def orders_chart_data
    orders_by_day = Order.total_grouped_by_day(24.weeks.ago)
    @orders_by_day = orders_by_day
    #(24.weeks.ago.to_date..Date.today).map do |date|
    (24.weeks.ago.to_date..14.weeks.ago.to_date).map do |date|
      {
        created_at: date,
        orders_count: orders_by_day[date]
      }
    end
  end


  def year_order_data
    year_order_by_day = Order.total_grouped_by_day(52.weeks.ago)
    @year_order_by_day = year_order_by_day
    #(24.weeks.ago.to_date..Date.today).map do |date|
    (52.weeks.ago.to_date..Time.zone.now.to_date).map do |date|
      {
        created_at: date,
        orders_count: year_order_by_day[date]
      }
    end
  end

end

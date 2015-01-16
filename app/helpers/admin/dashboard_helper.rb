module Admin::DashboardHelper
  def all_chart_data
    quotes_by_day = Quote.total_quotes_grouped_by_day(6.weeks.ago)
    @quotes_by_day = quotes_by_day

    orders_by_day = Order.total_grouped_by_day(6.weeks.ago)
    @orders_by_day = orders_by_day

    purchases_by_day = Purchase.total_purchases_grouped_by_day(6.weeks.ago)
    @purchases_by_day = purchases_by_day

    # (24.weeks.ago.to_date..Date.today).map do |date|
    (6.weeks.ago.to_date..Time.zone.now.to_date).map do |date|
      {
        created_at: date,
        orders_count: orders_by_day[date],
        quotes_count: quotes_by_day[date],
        purchases_count: quotes_by_day[date]
      }
    end
  end


  def year_chart_data
    all_year_quotes_by_day = Quote.total_quotes_grouped_by_day(52.weeks.ago)
    @all_year_quotes_by_day = all_year_quotes_by_day

    all_year_orders_by_day = Order.total_grouped_by_day(52.weeks.ago)
    @all_year_orders_by_day = all_year_orders_by_day

    all_year_purchases_by_day = Purchase.total_purchases_grouped_by_day(52.weeks.ago)
    @all_year_purchases_by_day = all_year_purchases_by_day

    # (24.weeks.ago.to_date..Date.today).map do |date|
    (52.weeks.ago.to_date..Time.zone.now.to_date).map do |date|
      {
        created_at: date,
        orders_count: all_year_orders_by_day[date],
        quotes_count: all_year_quotes_by_day[date],
        purchases_count: all_year_quotes_by_day[date]
      }
    end
  end


  def order_year_chart_data
    order_day_year = Order.total_grouped_by_day(52.weeks.ago)
    @order_day_year = order_day_year
    #(24.weeks.ago.to_date..Date.today).map do |date|
    (52.weeks.ago.to_date..Time.zone.now.to_date).map do |date|
      {
        created_at: date,
        orders_count: order_day_year[date]
      }
    end
  end

  def quote_year_chart_data
    quote_day_year = Quote.total_quotes_grouped_by_day(52.weeks.ago)
    @quote_day_year = quote_day_year
    #(24.weeks.ago.to_date..Date.today).map do |date|
    (52.weeks.ago.to_date..Time.zone.now.to_date).map do |date|
      {
        created_at: date,
        quotes_count: quote_day_year[date]
      }
    end
  end

  def purchase_year_chart_data
    purchase_day_year = Purchase.total_purchases_grouped_by_day(52.weeks.ago)
    @purchase_day_year = purchase_day_year
    #(24.weeks.ago.to_date..Date.today).map do |date|
    (52.weeks.ago.to_date..Time.zone.now.to_date).map do |date|
      {
        created_at: date,
        purchases_count: purchase_day_year[date]
      }
    end
  end

end

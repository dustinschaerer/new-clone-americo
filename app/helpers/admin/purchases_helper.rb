module Admin::PurchasesHelper
  def purchases_chart_data
    purchases_by_day = Purchase.total_purchases_grouped_by_day(24.weeks.ago)
    @purchases_by_day = purchases_by_day
    # (24.weeks.ago.to_date..Date.today).map do |date|
    (24.weeks.ago.to_date..14.weeks.ago.to_date).map do |date|
      {
        created_at: date,
        purchases_count: purchases_by_day[date]
      }
    end
  end
end

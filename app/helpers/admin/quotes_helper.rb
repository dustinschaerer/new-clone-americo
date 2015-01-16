module Admin::QuotesHelper
  def quotes_chart_data
    quotes_by_day = Quote.total_quotes_grouped_by_day(24.weeks.ago)
    @quotes_by_day = quotes_by_day
    # (24.weeks.ago.to_date..Date.today).map do |date|
    (24.weeks.ago.to_date..14.weeks.ago.to_date).map do |date|
      {
        created_at: date,
        quotes_count: quotes_by_day[date]
      }
    end
  end
end

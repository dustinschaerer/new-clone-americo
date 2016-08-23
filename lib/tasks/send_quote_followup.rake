desc "send quote followup email"
task :send_quote_followup => :environment do

	# target date = how many days to look back at submitted quotes
	target_date = 4.days.ago
	target_quotes = []
	target_quotes = Quote.where(created_at: target_date.beginning_of_day..target_date.end_of_day)
  # only send to one email
	uniqued = target_quotes.group_by(&:email).map{|k, v| v.first}

  uniqued.each do |quote|
    purchase = Purchase.find_by_quote_id(quote)
    quote.status == "Offline-Purchased"
    unless quote.status == "Offline-Purchased" || purchase.present? || quote.status == "Purchased"
      QuoteNotifier.quote_followup_detail(quote).deliver
    end
    # QuoteNotifier.quote_followup_detail(quote).deliver unless purchase.present?
	end
end
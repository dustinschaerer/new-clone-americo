class Order < ActiveRecord::Base

	has_many :line_items, dependent: :destroy
	belongs_to :user

  accepts_nested_attributes_for :line_items

	validates :firstname, :lastname, :street_address, :city, :zipcode, :state, :country, :email, :user_id, :status, presence: true
  validates :state, inclusion: ::STATES, if: :is_usa?
  validates :state, inclusion: ::PROVINCES, if: :is_canada?

  def is_usa?
    (country == 'United States')
  end

  def is_canada?
    (country == 'Canada')
  end

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
  end

  def is_complete?
    if (self.status == "Shipped")
     	true
    end
  end

  def current_color
    if (self.status == "Submitted")
      return :warn
    elsif (self.status == "Shipped")
      return :ok
    elsif (self.status == "Offline Purchased")
      return :offline_purchased
    elsif (self.status == "Purchased")
      return :error
    end
  end

  def self.total_grouped_by_day(start)
    orders = where(created_at: start.beginning_of_day..Time.zone.now)
    orders = orders.group("date(created_at)")
    orders = orders.select("date(created_at) as created_at, count(*) as count")
    #orders.group_by { |o| o.created_at.to_date }
    orders.each_with_object({}) do |order, counts|
      counts[order.created_at.to_date] = order.count
    end
  end

  def self.created_between(start_date, end_date)
    where("created_at >= ? AND created_at <= ?", start_date, end_date)
  end

end

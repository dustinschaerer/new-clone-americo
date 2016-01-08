class InhouseCustomer < ActiveRecord::Base
  require 'csv'
  validates_presence_of :email
  validates_uniqueness_of :email
  belongs_to :inhouse_group

  def status
    self.subscribed ? 'Subscribed' : 'Unsubscribed'
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |inhouse_customer|
        csv << inhouse_customer.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      inhouse_customer_hash = row.to_hash
      inhouse_customer = InhouseCustomer.where(email: inhouse_customer_hash["email"])
      if inhouse_customer.count ==1
        inhouse_customer.first.update_attributes(inhouse_customer_hash)
      else
        InhouseCustomer.create!(inhouse_customer_hash)
      end
    end
  end

end
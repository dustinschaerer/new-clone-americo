class AddSubscribedToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :subscribed, :boolean, :default => true
  end
end

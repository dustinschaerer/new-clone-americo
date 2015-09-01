class RemoveUnsubscribedFromProspects < ActiveRecord::Migration
  def up
    remove_column :prospects, :unsubscribed
  end

  def down
    add_column :prospects, :unsubscribed, :boolean
  end
end

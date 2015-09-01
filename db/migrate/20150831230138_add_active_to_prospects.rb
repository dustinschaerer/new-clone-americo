class AddActiveToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :active, :boolean, :default => true
  end
end

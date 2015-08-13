class AddProspectGroupIdToProspects < ActiveRecord::Migration
  def change
    add_reference :prospects, :prospect_group, index: true
  end
end
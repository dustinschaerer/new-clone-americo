class SetValidatedToFalseOnProspects < ActiveRecord::Migration
  def up
    Prospect.update_all(validated: false)
  end

  def down
    Prospect.update_all(validated: nil)
  end
end

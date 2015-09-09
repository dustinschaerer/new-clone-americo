class CreateMandrilTags < ActiveRecord::Migration
  def change
    create_table :mandril_tags do |t|
      t.string :title

      t.timestamps
    end
  end
end

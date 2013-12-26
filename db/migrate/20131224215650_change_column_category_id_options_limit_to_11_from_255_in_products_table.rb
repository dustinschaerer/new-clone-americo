class ChangeColumnCategoryIdOptionsLimitTo11From255InProductsTable < ActiveRecord::Migration
  def change
    change_column(:products, :category_id, :integer, {limit: 11})
  end
end

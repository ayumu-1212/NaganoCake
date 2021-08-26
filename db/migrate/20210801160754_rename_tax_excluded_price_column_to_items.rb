class RenameTaxExcludedPriceColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :tax_excluded_price, :price
  end
end

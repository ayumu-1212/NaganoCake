class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.text :description
      t.integer :sales_status
      t.integer :tax_excluded_price
      t.text :image_id
      t.timestamps
    end
  end
end

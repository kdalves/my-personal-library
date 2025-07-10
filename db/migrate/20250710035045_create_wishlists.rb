class CreateWishlists < ActiveRecord::Migration[8.0]
  def change
    create_table :wishlists do |t|
      t.references :books, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end

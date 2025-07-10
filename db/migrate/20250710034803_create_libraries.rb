class CreateLibraries < ActiveRecord::Migration[8.0]
  def change
    create_table :libraries do |t|
      t.references :books, foreign_key: true
      t.string :name
      t.integer :status
      t.boolean :virtual

      t.timestamps
    end
  end
end

class CreateDrinks < ActiveRecord::Migration[8.0]
  def change
    create_table :drinks do |t|
      t.string :name, null: false
      t.integer :serv_count, null: false
      t.decimal :serv_caffeine, null: false

      t.timestamps
    end
  end
end

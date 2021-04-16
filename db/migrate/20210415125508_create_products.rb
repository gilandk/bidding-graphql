class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :lowest_bid
      t.integer :starting_bid
      t.date :expire_bid
      t.boolean :stop_bid, default: 0

      t.timestamps
    end
  end
end

class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string  :from
      t.string  :to
      t.decimal :from_latitude, precision: 16, scale:10
      t.decimal :from_longitude, precision: 16, scale:10
      t.decimal :to_longitude, precision: 16, scale:10
      t.decimal :to_latitude, precision: 16, scale:10 
      t.decimal :distance, precision: 6, scale:2
      t.date    :rode_date
      t.integer :provider_id
      t.decimal :price, precision: 6, scale:2

      t.timestamps null: false
    end
  end
end

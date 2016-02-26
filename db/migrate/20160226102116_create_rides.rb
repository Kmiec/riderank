class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string  :from
      t.string  :to
      t.decimal :from_lattitude
      t.decimal :from_longitude
      t.decimal :to_longitude
      t.decimal :to_lattitude
      t.decimal :distance
      t.date    :rode_date
      t.integer :provider_id
      t.decimal :price

      t.timestamps null: false
    end
  end
end

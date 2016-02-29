class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.integer :year
      t.integer :value
      t.string :continent_id

      t.timestamps null: false
    end
  end
end

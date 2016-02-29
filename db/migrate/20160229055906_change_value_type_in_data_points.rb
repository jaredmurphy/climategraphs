class ChangeValueTypeInDataPoints < ActiveRecord::Migration
  def change
    change_column :data_points, :value, :float
  end
end

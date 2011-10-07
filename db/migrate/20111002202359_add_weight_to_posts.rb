class AddWeightToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :weight, :integer, :default => 1
  end
end

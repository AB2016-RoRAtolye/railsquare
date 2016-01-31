class AddImageToCheckIns < ActiveRecord::Migration
  def change
    add_column :check_ins, :image, :string
  end
end

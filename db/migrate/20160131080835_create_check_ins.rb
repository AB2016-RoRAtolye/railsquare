class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
    	t.references :user
    	t.references :venue

      t.timestamps null: false
    end
  end
end

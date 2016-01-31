class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
    	t.string :name
    	t.text :address
    	t.references :category
    	t.float :latitude
    	t.float :longitude

      t.timestamps null: false
    end
  end
end

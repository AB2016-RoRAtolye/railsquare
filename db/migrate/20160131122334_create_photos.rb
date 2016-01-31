class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :check_in
      t.string :image

      t.timestamps null: false
    end
  end
end

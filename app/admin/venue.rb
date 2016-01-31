ActiveAdmin.register Venue do
	permit_params :name, :address, :category_id

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :category
    column :created_at
    actions
  end

  filter :name
  filter :address
  filter :category
  filter :created_at

  form do |f|
    f.inputs "Venue Details" do
      f.input :name
      f.input :category
      f.input :address
    end
    f.actions
  end

end

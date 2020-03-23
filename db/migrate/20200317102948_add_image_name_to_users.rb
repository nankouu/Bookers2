class AddImageNameToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :Users, :image_name, :string
  end
end

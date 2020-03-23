class AdduserIdToBooks < ActiveRecord::Migration[5.2]
  def change
  	add_column :Books, :user_id, :string
  end
end

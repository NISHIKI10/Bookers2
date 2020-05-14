class AddProfileImagedIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_imaged_id, :string
  end
end

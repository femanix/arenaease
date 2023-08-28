class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :super_admin, :boolean, default: false, null: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end

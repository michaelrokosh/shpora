class AddSocialNetworksColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :social_url, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end

class AddAwsColumnsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :file_url, :string
  end
end

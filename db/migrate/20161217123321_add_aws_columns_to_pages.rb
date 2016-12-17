class AddAwsColumnsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :content_key, :string
    add_column :pages, :content_processed, :boolean, default: false
  end
end

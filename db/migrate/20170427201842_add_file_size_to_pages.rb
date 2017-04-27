class AddFileSizeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :filesize, :decimal
    add_column :pages, :source, :integer
  end
end

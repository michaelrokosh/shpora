class AddAmountToPages < ActiveRecord::Migration
  def change
    add_column :pages, :amount, :decimal
    add_column :users, :total_amount, :decimal
  end
end

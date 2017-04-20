class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider, index: true
      t.string :uid, index: true
      t.string :token
      t.string :token_expires_at

      t.timestamps null: false
    end
  end
end

class CreateIcoTable < ActiveRecord::Migration[5.1]
  def change
    create_table :icos do |t|
    t.string :ticker
    t.string :name
    t.date :ico_date
    t.boolean :whitelist?
    t.integer :user_id
    end
  end
end

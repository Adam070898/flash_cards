class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :user
      t.integer :deck_id
      t.integer :correct
      t.timestamps null: false
    end
  end
end

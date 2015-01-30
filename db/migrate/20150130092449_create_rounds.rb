class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :correct
      t.integer :blank
      t.timestamps null: false
    end
  end
end

class CreateRoundsUser < ActiveRecord::Migration
  def change
    create_table :rounds_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :round, index: true
    end
  end
end

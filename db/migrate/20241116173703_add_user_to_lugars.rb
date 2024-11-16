class AddUserToLugars < ActiveRecord::Migration[7.0]
  def change
    add_reference :lugars, :user, null: true, foreign_key: true
  end
end

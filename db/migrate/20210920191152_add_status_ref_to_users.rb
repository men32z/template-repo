class AddStatusRefToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :status, null: true, foreign_key: { to_table: :status}
  end
end

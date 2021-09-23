class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :external_id
      t.integer :external_provider
      t.string :external_created_at
      t.timestamps
    end

    add_index :users, [:external_id, :external_provider], unique: true
    add_index :users, :email, unique: true
  end
end

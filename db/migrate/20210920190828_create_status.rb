class CreateStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :status do |t|
      t.string :name
    end
  end
end

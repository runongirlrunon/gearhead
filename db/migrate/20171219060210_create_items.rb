class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :brand
      t.text :model
      t.text :ssn
      t.text :cost
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :items, [:user_id, :created_at]
  end
end

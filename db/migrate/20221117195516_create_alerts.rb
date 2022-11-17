class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :address
      t.integer :upvotes
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    rename_column :alerts, :user_id, :creator_id

  end
end

class CreateStatusUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :status_updates do |t|
      t.boolean :is_up
      t.text :message

      t.timestamps
      t.index :created_at
    end
  end
end

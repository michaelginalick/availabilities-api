class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.timestamp :start_time, null: false
      t.timestamp :end_time, null: false

      t.timestamps
    end
    add_index :slots, :id
  end
end

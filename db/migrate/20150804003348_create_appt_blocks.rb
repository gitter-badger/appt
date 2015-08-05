class CreateApptBlocks < ActiveRecord::Migration
  def change
    create_table :appt_blocks do |t|
      t.string :name
      t.integer :calendar_id
      t.date :day, null: false
      t.string :start, null: false
      t.string :end, null: false

      t.timestamps null: false
    end
  end
end


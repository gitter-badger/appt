class CreateApptBlocks < ActiveRecord::Migration
  def change
    create_table :appt_blocks do |t|

      t.timestamps null: false
    end
  end
end

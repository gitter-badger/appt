class AddAllowedOverlapToCalendars < ActiveRecord::Migration
  def change
    add_column :appt_calendars, :allowed_overlap, :integer, null: false, default: 1
  end
end

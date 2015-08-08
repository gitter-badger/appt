module Appt
  class ExternalCalendar < ActiveRecord::Base
    SYNC_BUFFER = 1.day

    has_many :blocks, dependent: :destroy
    has_many :calendars, ->{ distinct }, through: :blocks

    validates :url, presence: true

    def sync_metadata
      cal = fetch_calendars.first
      self.name = cal.custom_properties['x_wr_calname']
        .join('; ') if cal && cal.custom_properties['x_wr_calname']
    end

    def sync(target)
      # TODO: more incremental sync? would need to detect removed events, as
      # well as handle groups under same id with group_by{ |e| e[:external_id] }

      transaction do
        blocks.where(calendar_id: target.id).delete_all
        today = target.today
        min_date = today - SYNC_BUFFER
        max_date = today + target.max_days.days + SYNC_BUFFER

        IcalendarExpander.new(target.timezone, fetch_calendars).events(min_date, max_date) do |event|
          blocks.create!(event.merge(calendar_id: target.id))
        end
      end
    end

  private

    def fetch_calendars
      response = Faraday.get(url)
      Icalendar.parse(response.body)
    end
  end
end


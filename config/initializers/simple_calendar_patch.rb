SimpleCalendar::Calendar.class_eval do
  attr_reader :timezone

  def start_date_with_timezone
    @start_date ||= (get_option(:start_date) || params[param_name] || timezone.now).to_date
  end
  alias_method_chain :start_date, :timezone

  def default_td_classes_with_timezone
    ->(start_date, current_calendar_date) {
      today = timezone.now.to_date
      td_class = ["day"]
      td_class << "today"  if today == current_calendar_date
      td_class << "past"   if today > current_calendar_date
      td_class << "future" if today < current_calendar_date
      td_class << 'start-date'    if current_calendar_date.to_date == start_date.to_date
      td_class << "prev-month"    if start_date.month != current_calendar_date.month && current_calendar_date < start_date
      td_class << "next-month"    if start_date.month != current_calendar_date.month && current_calendar_date > start_date
      td_class << "current-month" if start_date.month == current_calendar_date.month
      td_class << "wday-#{current_calendar_date.wday.to_s}"
      td_class << "has-events" if events_for_date(current_calendar_date).any?

      { class: td_class.join(" ") }
    }
  end
  alias_method_chain :default_td_classes, :timezone
end

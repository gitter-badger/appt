Workhours::Period.class_eval do
  def initialize_with_exclude_end(wday, beginning, ending)
    initialize_without_exclude_end(wday, beginning, ending)

    @shift = Tod::Shift.new(@shift.beginning, @shift.ending, true)
  end
  alias_method_chain :initialize, :exclude_end
end

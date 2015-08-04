Tod::Shift.class_eval do
  def slide(seconds)
    self.class.new(beginning + seconds, ending + seconds, exclude_end?)
  end
end


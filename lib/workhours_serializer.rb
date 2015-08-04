module WorkhoursSerializer
  def self.dump(week)
    JSON.dump(week.try(:export))
  end

  def self.load(options)
    options = JSON.load(options)

    Workhours::Week.new(options) if options
  end
end


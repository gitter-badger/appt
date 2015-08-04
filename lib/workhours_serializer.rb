module WorkhoursSerializer
  def self.dump(week)
    JSON.dump(week.try(:export))
  end

  def self.load(options)
    options = JSON.load(options)

    if options
      Workhours::Week.new(options)
    else
      nil
    end
  end
end

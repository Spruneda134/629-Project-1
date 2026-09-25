class Report
  def initialize(activityName)

    if activityName.nil? || activityName.empty?
        raise ArgumentError, 'Activity name cannot be nil or empty'
    end

    @activityName = activityName
    @date = Time.now
  end

  attr_reader :activityName


end

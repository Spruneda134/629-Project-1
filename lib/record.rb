# frozen_string_literal: true

# One set of an activity: weight, reps and optional RPE.
class Record
  attr_reader :weight,

  def initialize(activityName, weight)
    raise ArgumentError, 'Weight cannot be negative' if weight.negative?

    @activityName = activityName
    @weight = weight
  end
end

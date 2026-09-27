# frozen_string_literal: true

# One set of an activity: weight, reps and optional RPE.
class Record
  attr_reader :weight

  def initialize(activity_name, weight)
    raise ArgumentError, 'Weight cannot be negative' if weight.negative?

    @activity_name = activity_name
    @weight = weight
  end
end

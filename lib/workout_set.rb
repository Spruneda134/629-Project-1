# frozen_string_literal: true

# One set of an activity: weight, reps and optional RPE.
class WorkoutSet
  attr_reader :weight, :reps, :rpe

  def initialize(weight, reps, rpe = nil)
    raise ArgumentError, 'Weight cannot be negative' if weight.negative?

    raise ArgumentError, 'Reps cannot be negative' if reps.negative?

    raise ArgumentError, 'RPE must be between 1 and 10' if rpe && !rpe.between?(1, 10)

    @weight = weight
    @reps = reps
    @rpe = rpe
  end
end

class WorkoutSet
  attr_reader :weight, :reps, :rpe

  def initialize(weight, reps, rpe = nil)
    @weight = weight
    @reps = reps
    @rpe = rpe
  end
end

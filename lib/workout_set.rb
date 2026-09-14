class WorkoutSet

  def initialize(weight, reps, rpe)
    @weight = weight
    @reps = reps
    @rpe = rpe
  end

  attr_reader :weight, :reps, :rpe
end

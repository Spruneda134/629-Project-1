class WorkoutSet
  attr_reader :weight, :reps, :rpe

  def initialize(weight, reps, rpe = nil)

    raise ArgumentError, "Weight cannot be negative" if weight < 0
      
    raise ArgumentError, "Reps cannot be negative" if reps < 0
      
    if rpe && !rpe.between?(1, 10)
      raise ArgumentError, "RPE must be between 1 and 10"
    end

    @weight = weight
    @reps = reps
    @rpe = rpe
  end
end

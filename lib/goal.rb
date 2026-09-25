class Goal
  def initialize(name, target)
    raise ArgumentError, 'Name cannot be empty' if name.strip.empty?
    raise ArgumentError, 'Target must be an integer' unless target.is_a?(Integer)
    raise ArgumentError, 'Target cannot be negative' if target < 0

    @name = name
    @target = target
    @completed = false
    @date = Time.now
  end

  attr_reader :name, :target, :completed, :date

  def edit_name(new_name)
    raise ArgumentError, 'Name cannot be empty' if new_name.strip.empty?

    @name = new_name
  end

  def edit_target(new_target)
    raise ArgumentError, 'Target must be an integer' unless new_target.is_a?(Integer)
    raise ArgumentError, 'Target cannot be negative' if new_target < 0

    @target = new_target
  end

  def toggle_completed
    @completed = !@completed
  end
end

class Goal
  def initialize(name, target)
    @name = name
    @target = target
    @completed = false
    @date = Time.now
  end

  attr_reader :name, :target, :completed, :date

  def edit_name(new_name)
    @name = new_name
  end

  def edit_target(new_target)
    @target = new_target
  end

  def toggle_completed
    @completed = !@completed
  end
end
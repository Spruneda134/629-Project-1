# frozen_string_literal: true

require_relative 'workout_set'

class Activity
  attr_reader :name, :sets, :metric_value

  def initialize(name, metric_value = 'lbs')
    raise ArgumentError, 'name must be a string.' unless name.is_a?(String)

    @sets = []
    @name = name
    @metric_value = metric_value
    @set_index = 0
  end

  def edit_name(new_name)
    @name = new_name
  end

  def add_set(set)
    raise ArgumentError, 'Invalid WorkoutSet' unless set.is_a?(WorkoutSet)

    @sets << set
  end

  def view_sets
    @sets.each do |set|
      puts "\nSet #{@sets.index(set) + 1}:"
      puts "Weight: #{set.weight} lbs"
      puts "Reps: #{set.reps}"
      puts "RPE: #{set.rpe}" if set.rpe
    end
  end

  def edit_metric_value(new_metric_value)
    @metric_value = new_metric_value
  end
end

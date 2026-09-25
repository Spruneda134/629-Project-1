# frozen_string_literal: true

require 'workout_set'

class Activity
  attr_reader :name, :sets, :metric_value

  def initialize(name, metric_value = 'lbs')
    raise ArgumentError, 'name must be a string.' unless name.is_a?(String)

    @sets = []
    @name = name
    @metric_value = metric_value
    @set_count = 0
  end

  def edit_name(new_name)
    @name = new_name
  end

  def add_set(set)
    raise ArgumentError, 'Invalid WorkoutSet' unless set.is_a?(WorkoutSet)

    @sets << set
    @set_count += 1
  end

  def view_sets
    @sets.each do |set|
      puts set
    end
  end

  def edit_metric_value(new_metric_value)
    @metric_value = new_metric_value
  end
end

# frozen_string_literal: true

class Activity
  def initialize(name, metric_value)
    @sets = []
    @name = name
    @metric_value = metric_value
    @set_count = 0
  end

  attr_reader :name, :metric_value

  def edit_name(new_name)
    @name = new_name
  end

  def add_set(set)
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

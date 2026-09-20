# frozen_string_literal: true

require 'activity'

class Session
  attr_reader :name, :date, :activities

  def initialize(name = 'workout')
    @name = name
    @date = Time.now
    @activities = []
  end

  def edit_name(new_name)
    @name = new_name
  end

  def add_activity(activity)
    unless activity.is_a?(Activity)
      raise ArgumentError, "Expected an Activity, got #{activity.class}"
    end

    @activities << activity
  end

  def view_activities
    @activities.each do |activity|
      puts activity.name
    end
  end
end
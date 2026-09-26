# frozen_string_literal: true

require_relative 'activity'

class Session
  attr_reader :name, :date, :activities

  def initialize(name = 'Workout', date = nil)
    raise ArgumentError, 'Name cannot be empty' if name.strip.empty?

    @name = name

    @date = date.nil? ? Time.now : date

    @activities = []
  end

  def edit_name(new_name)
    @name = new_name
  end

  def add_activity(activity)
    raise ArgumentError, 'Activity name already exists' if @activities.any? do |s|
      s.name.downcase == activity.name.downcase
    end
    raise ArgumentError, "Expected an Activity, got #{activity.class}" unless activity.is_a?(Activity)

    @activities << activity
  end

  def view_activities
    @activities.each do |activity|
      puts activity.name
    end
  end
end

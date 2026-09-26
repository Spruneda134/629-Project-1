# frozen_string_literal: true

require 'activity'

class Session
  attr_reader :name, :date, :activities

  def initialize(name, date = nil)
    raise ArgumentError, 'Name cannot be empty' if name.strip.empty?

    @name = name

    @date = date.nil? ? Time.now : date

    @activities = []
  end

  def edit_name(new_name)
    @name = new_name
  end

  def add_activity(activity)
    raise ArgumentError, "Expected an Activity, got #{activity.class}" unless activity.is_a?(Activity)

    @activities << activity
  end

  def view_activities
    @activities.each do |activity|
      puts activity.name
    end
  end
end

# frozen_string_literal: true

class Session
  def initialize(name)
    @name = name
    @activity_count = 0
    @date = Time.now
    @activities = []
  end

  attr_reader :name, :date

  def edit_name(new_name)
    @name = new_name
  end

  def add_activity(activity)
    @activities << activity
    @activity_count += 1
  end

  def view_activities
    @activities.each do |activity|
      puts activity
    end
  end
end

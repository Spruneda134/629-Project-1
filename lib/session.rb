# frozen_string_literal: true

class Session
  def initialize(name)
    @name = name
    @date = Time.now
    @activities = []
  end

  attr_reader :name, :date, :activities

  def edit_name(new_name)
    @name = new_name
  end

  def add_activity(activity)
    @activities << activity
  end

  def view_activities
    @activities.each do |activity|
      puts activity
    end
  end
end

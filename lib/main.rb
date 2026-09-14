# frozen_string_literal: true

class Main
  def initialize
    @records = []
    @goals = []
    @sessions = []
    @session_count = 0
  end

  def add_record(record)
    @records << record
  end

  def view_records
    @records.each do |record|
      puts record
    end
  end

  def add_goal(goal)
    @goals << goal
  end

  def view_goals
    @goals.each do |goal|
      puts goal
    end
  end

  def add_session(session)
    @sessions << session
    @session_count += 1
  end

  def view_sessions
    @sessions.each do |session|
      puts session
    end
  end
end

class Goal
  def initialize(name, target)
    @name = name
    @target = target
    @completed = false
    @date = Time.now
  end

  attr_reader :name, :target

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

class Record
  def initialize(name, value)
    @name = name
    @value = value
    @date = Time.now
  end

  attr_reader :name, :value
end

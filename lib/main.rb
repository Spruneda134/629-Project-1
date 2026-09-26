# frozen_string_literal: true

class Main
  attr_reader :sessions, :goals, :records

  def initialize
    @records = {}
    @goals = []
    @sessions = []
  end

  def add_record(activity_name, weight)
    return unless !@records.key?(activity_name) || weight > @records[activity_name]

    @records[activity_name] = weight
  end

  def view_all_records
    @records.each do |activity_name, record|
      puts "#{activity_name}: #{record}"
    end
  end

  def view_record(activity_name)
    raise ArgumentError, 'Activity does not exist in the records.' unless @records.key?(activity_name)

    puts "#{activity_name}: #{@records[activity_name]}"
  end

  def add_goal(goal)
    @goals << goal
  end

  def view_goals
    @goals.each do |goal|
      puts goal.name
      puts "Target: #{goal.target} lbs"
    end
  end

  def view_completed_goals
    completed_goals = @goals.select(&:completed)
    completed_goals.each do |goal|
      puts goal.name
      puts "Target: #{goal.target} lbs"
    end
  end

  def view_incomplete_goals
    incomplete_goals = @goals.reject(&:completed)
    incomplete_goals.each do |goal|
      puts goal.name
      puts "Target: #{goal.target} lbs"
    end
  end

  def add_session(session)
    raise ArgumentError, 'Session name already exists' if @sessions.any? { |s| s.name.downcase == session.name.downcase }
    raise ArgumentError, 'Name cannot be empty' if session.name.empty?
    raise ArgumentError, 'Name cannot be empty' if session.name == 'exit'

    @sessions << session

    session.activities.each do |activity|
      activity_max = 0
      activity.sets.each do |set|
        activity_max = set.weight if set.weight > activity_max
      end

      @records[activity.name] = activity_max if !@records.key?(activity.name) || activity_max > @records[activity.name]
    end
  end

  def view_sessions
    @sessions.each do |session|
      puts session.name
    end
  end
end
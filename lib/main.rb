# frozen_string_literal: true

require 'report'

class Main

  attr_reader :sessions, :goals, :records

  def initialize
    @records = {}
    @goals = []
    @sessions = []
  end

  def add_record(activity_name, weight)
    if !@records.key?(activity_name) || weight > @records[activity_name]
      @records[activity_name] = weight
    end
  end

  def view_all_records
    @records.each do |activity_name, record|
      puts "#{activity_name}: #{record}"
    end
  end

  def view_record(activity_name)
    unless @records.key?(activity_name)
      raise ArgumentError, "Activity does not exist in the records."
    end

    puts "#{activity_name}: #{@records[activity_name]}"
  end

  def create_activity_report(activity_name)
    unless @records.key?(activity_name)
      raise ArgumentError, "Activity does not exist in the records."
    end

    pr = @records[activity_name]
    unit = 'lbs'

    # one row per session containing the activity, oldest first
    history = []
    @sessions.each do |session|
      activities = session.activities.select { |activity| activity.name == activity_name }
      next if activities.empty?

      unit = activities.first.metric_value
      max_weight = activities.flat_map(&:sets).map(&:weight).max || 0
      history << { date: session.date, name: session.name, max_weight: max_weight }
    end
    history.sort_by! { |row| row[:date] }

    # earliest session where the PR weight was lifted (nil if the PR was added manually)
    pr_row = history.find { |row| row[:max_weight] == pr }

    Report.new(activity_name, pr, pr_row&.dig(:date), history, unit)
  end

  def view_activity_report(activity_name)
    puts create_activity_report(activity_name)
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

    raise ArgumentError, "Name cannot be empty" if session.name.empty?

    
    @sessions << session

    # update personal records for all activities in a session
    session.activities.each do |activity|
      activity_max = 0
      activity.sets.each do |set|
        if set.weight > activity_max
          activity_max = set.weight
        end
      end

      if !@records.key?(activity.name) || activity_max > @records[activity.name]
        @records[activity.name] = activity_max
      end
    end
  end

  def view_sessions
    @sessions.each do |session|
      puts session
    end
  end
end
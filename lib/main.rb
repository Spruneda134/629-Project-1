# frozen_string_literal: true

require 'json'
require 'fileutils'
require_relative 'report'
require_relative 'storage'

# Tracker that holds the user's sessions, goals and personal records with persistency.
class Main
  attr_reader :sessions, :goals, :records

  SAVE_PATH = File.expand_path('../data/tracker.json', __dir__)

  def initialize
    @records = {}
    @goals = []
    @sessions = []
  end

  def save(path = SAVE_PATH)
    data = {
      sessions: @sessions.map { |session| Storage.session_to_h(session) },
      goals: @goals.map { |goal| Storage.goal_to_h(goal) },
      records: @records
    }

    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, JSON.pretty_generate(data))
  end

  def load(path = SAVE_PATH)
    return unless File.exist?(path)

    data = JSON.parse(File.read(path))
    @sessions = data['sessions'].map { |session| Storage.session_from_h(session) }
    @goals = data['goals'].map { |goal| Storage.goal_from_h(goal) }
    @records = data['records']
  end

  # add personal records to the app
  def add_record(activity_name, weight)
    return unless !@records.key?(activity_name) || weight > @records[activity_name]

    @records[activity_name] = weight
  end

  # view all existing personal records
  def view_all_records
    @records.each do |activity_name, record|
      puts "#{activity_name}: #{record}"
    end
  end

  # view a specified record
  def view_record(activity_name)
    raise ArgumentError, 'Activity does not exist in the records.' unless @records.key?(activity_name)

    puts "#{activity_name}: #{@records[activity_name]}"
  end

  # create an activity report that shows users statistics on the workouts they have input
  def create_activity_report(activity_name)
    raise ArgumentError, 'Activity does not exist in the records.' unless @records.key?(activity_name)

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

    Report.new(activity_name, pr, pr_row&.dig(:date), history, unit: unit)
  end

  # view the activity report
  def view_activity_report(activity_name)
    puts create_activity_report(activity_name)
  end

  # add a goal/milestone to the app
  def add_goal(goal)
    @goals << goal
  end

  # allows a user to view the goals that they have set out
  def view_goals
    @goals.each do |goal|
      puts goal.name
      puts "Target: #{goal.target} lbs"
    end
  end

  # allows a user to view the completed goals that they have set out
  def view_completed_goals
    completed_goals = @goals.select(&:completed)
    completed_goals.each do |goal|
      puts goal.name
      puts "Target: #{goal.target} lbs"
    end
  end

  # allows a user to view the incomplete/in-progress goals that they have set out
  def view_incomplete_goals
    incomplete_goals = @goals.reject(&:completed)
    incomplete_goals.each do |goal|
      puts goal.name
      puts "Target: #{goal.target} lbs"
    end
  end

  # add a session to the app
  def add_session(session)
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

  # view the sessions on the app
  def view_sessions
    @sessions.each do |session|
      puts session.name
    end
  end
end

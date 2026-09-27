# frozen_string_literal: true

require 'time'
require_relative 'session'
require_relative 'activity'
require_relative 'workout_set'
require_relative 'goal'

# Converts tracker objects to and from plain hashes so Main can save them as JSON.
module Storage
  module_function

  def session_to_h(session)
    {
      name: session.name,
      date: session.date.iso8601(6),
      activities: session.activities.map { |activity| activity_to_h(activity) }
    }
  end

  def session_from_h(hash)
    session = Session.new(hash['name'], Time.iso8601(hash['date']))
    hash['activities'].each { |activity_hash| session.add_activity(activity_from_h(activity_hash)) }
    session
  end

  def activity_to_h(activity)
    {
      name: activity.name,
      metric_value: activity.metric_value,
      sets: activity.sets.map { |set| { weight: set.weight, reps: set.reps, rpe: set.rpe } }
    }
  end

  def activity_from_h(hash)
    activity = Activity.new(hash['name'], hash['metric_value'])
    hash['sets'].each { |set| activity.add_set(WorkoutSet.new(set['weight'], set['reps'], set['rpe'])) }
    activity
  end

  def goal_to_h(goal)
    { name: goal.name, target: goal.target, completed: goal.completed, date: goal.date.iso8601(6) }
  end

  def goal_from_h(hash)
    goal = Goal.new(hash['name'], hash['target'])
    goal.toggle_completed if hash['completed']
    goal
  end
end

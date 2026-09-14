# frozen_string_literal: true

class Main

attr_reader :sessions, :goals, :records

  def initialize
    @records = []
    @goals = []
    @sessions = []
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
  end

  def view_sessions
    @sessions.each do |session|
      puts session
    end
  end
end
# frozen_string_literal: true

require_relative 'main'
require_relative 'session'
require_relative 'activity'
require_relative 'workout_set'
require_relative 'goal'

# Command line menu for adding and browsing sessions, activities, sets and goals.
class Interface
  HEADER =
    "\n=========================================
            EXERCISE TRACKER
========================================="

  def initialize
    @main = Main.new
    @main.load
  end

  def start
    catch(:exit_app) do
      loop do
        puts HEADER
        puts '1. Add a Session'
        puts '2. View Sessions (view activities and sets)'
        puts '3. Open Goal Tracker'
        puts '4. Open Personal Record Tracker'
        puts '0. Exit'
        print 'Choose an option (1-3): '

        case read_input
        when '1'
          add_session_menu
        when '2'
          display_sessions
        when '3'
          open_goal_tracker
        when '4'
          open_record_tracker
        when '0'
          throw :exit_app
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end

    @main.save
    puts "\n> Goodbye!"
  end

  private

  def read_input
    input = gets.chomp
    throw :exit_app if input.casecmp('exit').zero?

    input
  end

  def add_session_menu
    loop do
      session_name = get_valid_name('> Enter Session Name: ')

      begin
        new_session = Session.new(session_name)
        @main.add_session(new_session)
        puts "\n> Session '#{session_name}' added successfully!"
      rescue ArgumentError => e
        puts "\n> Error: #{e.message}. Please try again."
        next
      end

      loop do
        puts "\nWhat would you like to do next?"
        puts "1. Add an activity to session '#{new_session.name}'"
        puts '2. Create another session'
        puts '3. Return to main menu'
        print 'Choose an option (1-3): '

        case read_input
        when '1'
          create_activity_flow(new_session)
          view_chosen_session(new_session)
          return
        when '2'
          break
        when '3'
          return
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  def display_sessions
    loop do
      puts HEADER
      puts "\n> Viewing sessions: "

      if @main.sessions.empty?
        puts "\n> No sessions found."
      else
        @main.view_sessions
      end

      puts "\n> Enter the name of the session to view its activities (or type 'exit' to quit):"

      session_name = read_input

      selected_session = @main.sessions.find { |s| s.name == session_name }

      if selected_session
        view_chosen_session(selected_session)
      else
        puts "\n> Session not found. Please try again."
      end
    end
  end

  def view_chosen_session(session)
    loop do
      puts HEADER
      puts "\n> Viewing activities in session: '#{session.name}'"

      if session.activities.empty?
        puts "\n> No activities found in this session."
      else
        session.view_activities
      end

      puts "\n1. Add an Activity"
      puts '2. Select an Activity (View/Add Sets)'
      puts '3. Return to Sessions List'
      print 'Choose an option (1-3): '

      case read_input
      when '1'
        create_activity_flow(session)
      when '2'
        puts "\n> Enter the name of the activity to select:"
        activity_name = read_input
        selected_activity = session.activities.find { |a| a.name == activity_name }

        if selected_activity
          view_chosen_activity(selected_activity)
        else
          puts "\n> Activity not found. Please try again."
        end
      when '3'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  def view_chosen_activity(activity)
    loop do
      puts HEADER
      puts "\n> Viewing sets for activity: '#{activity.name}'"

      if activity.sets.empty?
        puts "\n> No sets found for this activity."
      else
        activity.view_sets
      end

      puts "\n1. Add a Set"
      puts '2. Return to Activity List'
      print 'Choose an option (1-2): '

      case read_input
      when '1'
        add_set_to_activity(activity)
      when '2'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  def create_activity_flow(session)
    loop do
      activity_name = get_valid_name(" > Enter the name of the activity to add to '#{session.name}':")

      begin
        activity = Activity.new(activity_name)
        session.add_activity(activity)
        puts "\n> Activity '#{activity_name}' added successfully!"
      rescue ArgumentError => e
        puts "\n> Error: #{e.message}. Please try again."
        next
      end

      loop do
        puts "\nWhat would you like to do next?"
        puts "1. Add a set to activity '#{activity.name}'"
        puts '2. Create another activity'
        puts "3. Go back to session '#{session.name}' dashboard"
        print 'Choose an option (1-3): '

        case read_input
        when '1'
          add_sets_to_activity(activity)
        when '2'
          break
        when '3'
          return
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  def add_sets_to_activity(activity)
    loop do
      add_set_to_activity(activity)
      loop do
        puts "\n1. Add another set"
        puts '2. Return to activity options'
        print 'Choose an option (1-2): '

        case read_input
        when '1'
          break
        when '2'
          return
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  def add_set_to_activity(activity)
    puts "\n> Enter weight (lbs):"
    weight = read_input.to_f
    puts '> Enter reps:'
    reps = read_input.to_i
    puts '> Enter RPE (1-10) or leave blank:'
    rpe_input = read_input
    rpe = rpe_input.empty? ? nil : rpe_input.to_i

    begin
      activity.add_set(WorkoutSet.new(weight, reps, rpe))
      @main.add_record(activity.name, weight)
      puts "\n> Set added successfully!"

      matching_goal = @main.goals.find { |goal| goal.name.downcase == activity.name.downcase }
      if matching_goal && weight >= matching_goal.target && !matching_goal.completed
        matching_goal.toggle_completed
        puts "\n> Congratulations! You reached your goal of #{matching_goal.target} lbs for #{activity.name}!"
      end
    rescue ArgumentError => e
      puts "\n> Error: #{e.message}. Please try again."
    end
  end

  def get_valid_name(prompt_text)
    loop do
      puts "\n#{prompt_text}"
      name = read_input

      if name.empty?
        puts "\n> Name cannot be empty. Please try again."
      else
        return name
      end
    end
  end

  def get_valid_target(target_text)
    loop do
      puts "\n#{target_text}"
      target = read_input

      if target.empty?
        puts "\n> Target value cannot be empty. Please try again."
      elsif target.to_i <= 0
        puts "\n> Target value must be a positive integer. Please try again."
      else
        return target.to_i
      end
    end
  end

  def open_goal_tracker
    loop do
      puts HEADER
      puts "\n> Goal Tracker Menu:"
      puts '1. View Completed Goals'
      puts '2. View In-Progress Goals'
      puts '3. Add a Goal'
      puts '4. Return to Main Menu'
      print 'Choose an option (1-3): '

      case read_input
      when '1'
        if @main.goals.select(&:completed).empty?
          puts "\n> No completed goals found."
        else
          puts "\n> Viewing Completed Goals:"
          @main.view_completed_goals
        end
      when '2'
        if @main.goals.reject(&:completed).empty?
          puts "\n> No on-going goals found."
        else
          puts "\n> Viewing In-Progress Goals:"
          @main.view_incomplete_goals
        end
      when '3'
        goal_name = get_valid_name('> Enter the name of activity you would like to set a goal for:')

        target_value = get_valid_target('> Enter the target weight for this goal (lbs):')
        @main.add_goal(Goal.new(goal_name, target_value))
        puts "\n> Goal '#{goal_name}' added successfully!"
      when '4'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  def open_record_tracker
    loop do
      puts HEADER

        if @main.records.empty?
          puts "\n> No Personal Records Found."
        else
          puts "\n> Viewing Personal Records:"
          @main.view_all_records
        end

      puts "\n> Goal Tracker Menu:"
      puts '1. Return to Main Menu'
      print 'Choose an option (1): '

      case read_input
        when '1'
          break
        else
          puts "\n> Invalid choice. Please try again."
        end
    end
  end

end
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

  # starts up app
  def start
    catch(:exit_app) do
      loop do
        # main menu
        puts HEADER
        puts '1. Add a Session'
        puts '2. View/Edit Sessions'
        puts '3. Open Goal Tracker'
        puts '4. Open Personal Record Tracker'
        puts '5. View Activity Report'
        puts '0. Exit'
        print 'Choose an option (0-5): '

        case read_input
        when '1'
          # create a new session
          add_session_menu
        when '2'
          # opens the Sessions dashboard to view sessions and corresponding activities
          display_sessions
        when '3'
          # view and create goals
          open_goal_tracker
        when '4'
          # view personal records that have been set based on the activities that have been created
          open_record_tracker
        when '5'
          # create a detailed report based on the data from the sessions/activities created
          open_activity_report
          # exit app
        when '0'
          throw :exit_app
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end

    # save data
    @main.save
    puts "\n> Goodbye!"
  end

  private

  def read_input
    input = gets.chomp
    throw :exit_app if input.casecmp('exit').zero?

    input
  end

  # create a new session
  def add_session_menu
    loop do
      session_name = get_valid_name("> Enter Session Name (leave blank for 'Workout'): ", default: 'Workout')

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
        # Add an activity to current session
        when '1'
          if create_activity_flow(new_session) == :sessions_list
            display_sessions
          else
            view_chosen_session(new_session)
          end
          return
        # Create another session
        when '2'
          break
        # Return to main menu
        when '3'
          return
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  # pagination variables
  SESSIONS_PER_PAGE = 5
  PREV_PAGE = (SESSIONS_PER_PAGE + 1).to_s
  NEXT_PAGE = (SESSIONS_PER_PAGE + 2).to_s

  # pagination
  def display_sessions
    page = 0
    loop do
      puts HEADER
      sessions = @main.sessions.sort_by(&:date).reverse
      if sessions.empty?
        puts "\n> No sessions found."
        return
      end

      total_pages = (sessions.size.to_f / SESSIONS_PER_PAGE).ceil
      page = page.clamp(0, total_pages - 1)
      page_sessions = sessions.slice(page * SESSIONS_PER_PAGE, SESSIONS_PER_PAGE)

      puts "\n> Sessions (page #{page + 1} of #{total_pages})"
      print_sessions_table(page_sessions)

      puts
      puts "#{PREV_PAGE}. Previous page" if page.positive?
      puts "#{NEXT_PAGE}. Next page" if page < total_pages - 1
      puts '0. Return to main menu'
      print "Choose a session (1-#{page_sessions.size}) or an option: "

      input = read_input
      case input
      when '0'
        return
      when PREV_PAGE
        page.positive? ? page -= 1 : puts("\n> Already on the first page.")
      when NEXT_PAGE
        page < total_pages - 1 ? page += 1 : puts("\n> Already on the last page.")
      else
        index = Integer(input, exception: false)
        if index&.between?(1, page_sessions.size)
          view_chosen_session(page_sessions[index - 1])
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  # user interface method for displaying sessions
  def print_sessions_table(sessions)
    name_width = (['Session'] + sessions.map(&:name)).map(&:length).max
    puts
    puts "  #  #{'Session'.ljust(name_width)}  Date"
    puts "  -  #{'-' * name_width}  ----------"
    sessions.each_with_index do |session, i|
      puts "  #{i + 1}  #{session.name.ljust(name_width)}  #{session.date.strftime('%Y-%m-%d')}"
    end
  end

  # view and add activities for the chosen session
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
      # Add an Activity to the current session
      when '1'
        break if create_activity_flow(session) == :sessions_list
      # Select an Activity (View/Add Sets)
      when '2'
        puts "\n> Enter the name of the activity to select:"
        activity_name = read_input
        selected_activity = session.activities.find { |a| a.name == activity_name }

        if selected_activity
          view_chosen_activity(selected_activity)
        else
          puts "\n> Activity not found. Please try again."
        end
      # Return to Sessions List
      when '3'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  # view and create sets for the chosen activity
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
      # add a set to the current activity
      when '1'
        add_set_to_activity(activity)
      # Return to Activity List
      when '2'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  # simplifies propagating sessions by being able to add activities right after creating a session
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
        puts '4. Return to sessions list'
        print 'Choose an option (1-4): '

        case read_input
        # Add a set to activity
        when '1'
          add_sets_to_activity(activity)
        # Create another activity
        when '2'
          break
        # Go back to current session's dashoard
        when '3'
          return
        # Return to sessions list
        when '4'
          return :sessions_list
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  # add a set to an activity (main dashboard -> session -> activity -> set)
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

  # add a set to an acitivity (main dashboard -> session -> activity -> set)
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
      # checks to see if the inputed set's weight is a new Personal Record for the current activity
      @main.add_record(activity.name, weight)
      puts "\n> Set added successfully!"

      # checks to see if a goal has been completed by the inputed set's weight for the current activity
      matching_goal = @main.goals.find { |goal| goal.name.downcase == activity.name.downcase }
      if matching_goal && weight >= matching_goal.target && !matching_goal.completed
        matching_goal.toggle_completed
        puts "\n> Congratulations! You reached your goal of #{matching_goal.target} lbs for #{activity.name}!"
      end
    rescue ArgumentError => e
      puts "\n> Error: #{e.message}. Please try again."
    end
  end

  # for styling the interface
  def boxed(text)
    lines = text.lines.map(&:chomp)
    width = lines.map(&:length).max
    border = "+#{'-' * (width + 2)}+"
    [border, *lines.map { |line| "| #{line.ljust(width)} |" }, border].join("\n")
  end

  # ensures the name is not empty
  def get_valid_name(prompt_text, default: nil)
    loop do
      puts "\n#{prompt_text}"
      name = read_input
      return default if name.empty? && default

      if name.empty?
        puts "\n> Name cannot be empty. Please try again."
        next
      end

      return name
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

  # open up a report with data on the inputed activities
  def open_activity_report
    loop do
      puts HEADER
      activity_names = @main.records.keys.sort_by(&:downcase)

      if activity_names.empty?
        puts "\n> No activities recorded yet. Add a set to an activity first."
        return
      end

      puts "\n> Activities recorded:"
      activity_names.each_with_index { |name, i| puts "#{i + 1}. #{name}" }
      puts '0. Return to main menu'
      print "Choose an activity (0-#{activity_names.size}): "

      input = read_input
      return if input == '0'

      index = Integer(input, exception: false)
      unless index&.between?(1, activity_names.size)
        puts "\n> Invalid choice. Please try again."
        next
      end

      puts
      puts boxed(@main.create_activity_report(activity_names[index - 1]).to_s)

      loop do
        puts "\n1. View another activity report"
        puts '2. Return to main menu'
        print 'Choose an option (1-2): '

        case read_input
        # view activity reports
        when '1'
          break
        # return to main menu
        when '2'
          return
        else
          puts "\n> Invalid choice. Please try again."
        end
      end
    end
  end

  # view and create goals
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
      # View Completed Goals
      when '1'
        if @main.goals.select(&:completed).empty?
          puts "\n> No completed goals found."
        else
          puts "\n> Viewing Completed Goals:"
          @main.view_completed_goals
        end
      # View Incomplete/In-Progress Goals
      when '2'
        if @main.goals.reject(&:completed).empty?
          puts "\n> No on-going goals found."
        else
          puts "\n> Viewing In-Progress Goals:"
          @main.view_incomplete_goals
        end
      # add a goal
      when '3'
        goal_name = get_valid_name('> Enter the name of activity you would like to set a goal for:')

        target_value = get_valid_target('> Enter the target weight for this goal (lbs):')
        @main.add_goal(Goal.new(goal_name, target_value))
        puts "\n> Goal '#{goal_name}' added successfully!"
      # go back to main dashboard
      when '4'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  # menu to view personal records
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

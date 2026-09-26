require_relative 'main'
require_relative 'session'
require_relative 'activity'
require_relative 'workout_set'

class Interface
  HEADER = 
  "\n=========================================
                 EXERCISE TRACKER
    ========================================="

  def initialize
    @main = Main.new
  end

  def start
    loop do
      puts HEADER
      puts '1. Add a Session'
      puts '2. View Sessions (view activities and sets)'
      puts '3. Exit'
      print 'Choose an option (1-3): '

      case gets.chomp
      when '1'
        add_session_menu
      when '2'
        display_sessions
      when '3'
        puts "\n> Goodbye!"
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  private

  def add_session_menu
    session_name = get_valid_name("> Enter Session Name: ")
    new_session = Session.new(session_name)
    @main.add_session(new_session)
    puts "\n> Session '#{session_name}' added successfully!"
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

      puts "\n> Enter the name of the session to view its activities (or type 'exit' to return):"
      
      session_name = gets.chomp
      break if session_name.downcase == 'exit'

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
      puts "2. Select an Activity (View/Add Sets)"
      puts "3. Return to Sessions List"
      print "Choose an option (1-3): "

      case gets.chomp
      when '1'
        activity_name = get_valid_name("> Enter the name of the activity to add:")
        session.add_activity(Activity.new(activity_name))
        puts "\n> Activity '#{activity_name}' added successfully!"
      when '2'
        puts "\n> Enter the name of the activity to select:"
        activity_name = gets.chomp
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
      puts "2. Return to Activity List"
      print "Choose an option (1-2): "

      case gets.chomp
      when '1'
        puts "\n> Enter weight (lbs):"
        weight = gets.chomp.to_f
        puts "> Enter reps:"
        reps = gets.chomp.to_i
        puts "> Enter RPE (1-10) or leave blank:"
        rpe_input = gets.chomp
        rpe = rpe_input.empty? ? nil : rpe_input.to_i

        begin
          activity.add_set(WorkoutSet.new(weight, reps, rpe))
          puts "\n> Set added successfully!"
        rescue ArgumentError => e
          puts "\n> Error: #{e.message}. Please try again."
        end
      when '2'
        break
      else
        puts "\n> Invalid choice. Please try again."
      end
    end
  end

  def get_valid_name(prompt_text)
    loop do
      puts "\n#{prompt_text}"
      name = gets.chomp
      
      if name.empty?
        puts "\n> Name cannot be empty. Please try again."
      elsif name.downcase == 'exit'
        puts "\n> Name cannot be 'exit'. Please try again."
      else
        return name
      end
    end
  end
end
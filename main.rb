class Main
    def initialize()
        @records = []
        @goals = []
        @sessions = []
        @sessionCount = 0
    end

    def add_record(record)
        @records << record
    end

    def view_records()
        @records.each do |record|
            puts record
        end
    end

    def add_goal(goal)
        @goals << goal
    end

    def view_goals()
        @goals.each do |goal|
            puts goal
        end
    end

    def add_session(session)
        @sessions << session
        @sessionCount += 1
    end

    def view_sessions()
        @sessions.each do |session|
            puts session
        end
    end

end


class Session

    def initialize(name)
        @name = name
        @activityCount = 0
        @date = Time.now
        @activities = []
    end

    def name()
        @name
    end

    def edit_name(new_name)
        @name = new_name
    end

    def add_activity(activity)
        @activities << activity
        @activityCount += 1
    end

    def view_activities()
        @activities.each do |activity|
            puts activity
        end
    end

    def date()
        @date
    end

end

class Activity

    def initialize(name, weight, reps, sets)
        @name = name
        @activityCount = 0
        @date = Time.now
        @weight = weight
        @reps = reps
        @sets = sets
    end

    def name()
        @name
    end

    def edit_name(new_name)
        @name = new_name
    end

    def weight()
        @weight
    end

    def edit_weight(new_weight)
        @weight = new_weight
    end

    def reps()
        @reps
    end

    def edit_reps(new_reps)
        @reps = new_reps
    end

    def sets()
        @sets
    end

    def edit_sets(new_sets)
        @sets = new_sets
    end

end

class Goal

    def initialize(name, target)
        @name = name
        @target = target
        @completed = false
        @date = Time.now
    end

    def name()
        @name
    end

    def edit_name(new_name)
        @name = new_name
    end

    def target()
        @target
    end

    def edit_target(new_target)
        @target = new_target
    end

    def toggle_completed()
        @completed = !@completed
    end

end


class Record

    def initialize(name, value)
        @name = name
        @value = value
        @date = Time.now
    end

    def name()
        @name
    end

    def value()
        @value
    end

end



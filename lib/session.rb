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
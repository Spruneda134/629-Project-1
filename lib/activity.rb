# frozen_string_literal: true

class Activity

    def initialize(name, metricValue)
        @sets = []
        @name = name
        @metricValue = metricValue
        @setCount = 0
    end

    def name()
        @name
    end

    def edit_name(new_name)
        @name = new_name
    end

    def add_set(set)
        @sets << set
        @setCount += 1
    end

    def view_sets()
        @sets.each do |set|
            puts set
        end
    end

    def metricValue()
        @metricValue
    end

    def edit_metricValue(new_metricValue)
        @metricValue = new_metricValue
    end

end

class Set

    def initialize(weight, reps, rpe)
        @weight = weight
        @reps = reps
        @rpe = rpe
    end

end
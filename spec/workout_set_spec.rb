require 'workout_set'

RSpec.describe WorkoutSet do
    it 'create a set with a valid weight, reps, and rpe' do
        workout_set = WorkoutSet.new(10, 250, 8)

        expect(workout_set.weight).to eq(10)
        expect(workout_set.reps).to eq(250)
        expect(workout_set.rpe).to eq(8)
    end
end
require 'spec_helper'
require 'workout_set'

RSpec.describe WorkoutSet do
  context 'with valid attributes' do
    it 'create a set with a valid weight, reps, and rpe' do
      workout_set = WorkoutSet.new(10, 250, 8)

      expect(workout_set.weight).to eq(10)
      expect(workout_set.reps).to eq(250)
      expect(workout_set.rpe).to eq(8)
    end
  end

  context 'with invalid attributes' do
    it 'raises an error when weight is negative' do
      expect { WorkoutSet.new(-10, 250, 8) }.to raise_error(ArgumentError, 'Weight cannot be negative')
    end

    it 'raises an error when reps are negative' do
      expect { WorkoutSet.new(10, -5, 8) }.to raise_error(ArgumentError, 'Reps cannot be negative')
    end

    it 'raises an error when rpe is not within 1-10 range' do
      expect { WorkoutSet.new(10, 250, 11) }.to raise_error(ArgumentError, 'RPE must be between 1 and 10')
    end
  end
end

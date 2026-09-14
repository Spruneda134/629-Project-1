# frozen_string_literal: true

require 'activity'
require 'workout_set'

RSpec.describe Activity do
  it "Create a valid activity" do
    bicep_curls = Activity.new("Bicep Curls")
    bicep_curls.add_set(WorkoutSet.new(40, 5))
    bicep_curls.add_set(WorkoutSet.new(20, 10))

    expect(bicep_curls.sets[0].weight).to eq(40)
    expect(bicep_curls.sets[1].weight).to eq(20)
    expect(bicep_curls.sets[0].reps).to eq(5)
    expect(bicep_curls.sets[1].reps).to eq(10)
  end

  it "Create an invalid activity" do
    expect {
      Activity.new(40)
    }.to raise_error(ArgumentError)
  end
end
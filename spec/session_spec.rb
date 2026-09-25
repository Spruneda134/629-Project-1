require 'spec_helper'
require 'session'
require 'activity'
require 'workout_set'

RSpec.describe Session do
  context 'with valid attributes' do
    it 'create a session with an empty activity list and a valid name and date' do
      session = Session.new('Leg Day')

      expect(session.name).to eq('Leg Day')
      expect(session.date).to be_a(Time)
      expect(session.activities.length).to eq(0)
    end
  end

  context 'with invalid attributes' do
    it 'raises an error when new name is empty' do
      expect { Session.new('') }.to raise_error(ArgumentError, 'Name cannot be empty')
    end
  end
end

RSpec.describe Session do
  it 'edit session name' do
    session = Session.new('Arm Day')

    expect(session.name).to eq('Arm Day')
    session.edit_name('Chest Day')

    expect(session.name).to eq('Chest Day')
  end
end

RSpec.describe Session do
  it 'add a valid activity to a session' do
    session = Session.new('Arm Day')
    bicep_curls = Activity.new('Bicep Curls')
    bicep_curls.add_set(WorkoutSet.new(40, 5))
    bicep_curls.add_set(WorkoutSet.new(20, 10))
    session.add_activity(bicep_curls)
    expect(session.activities[0].name).to eq('Bicep Curls')
    expect(session.activities[0].sets[0].weight).to eq(40)
    expect(session.activities[0].sets[0].reps).to eq(5)
    expect(session.activities[0].sets[1].weight).to eq(20)
    expect(session.activities[0].sets[1].reps).to eq(10)
  end

  it 'add an invalid activity to a session' do
    session = Session.new('Arm Day')

    expect do
      session.add_activity('just a string')
    end.to raise_error(ArgumentError)
  end
end

RSpec.describe Session do
  it 'view activities in session' do
    session = Session.new('Arm Day')

    session.add_activity(Activity.new('Bicep Curls'))
    session.add_activity(Activity.new('Tricep Extensions'))

    expect { session.view_activities }.to output(
      "Bicep Curls\nTricep Extensions\n"
    ).to_stdout
  end
end

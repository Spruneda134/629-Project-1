require 'spec_helper'
require 'main'
require 'session'
require 'activity'
require 'workout_set'
require 'goal'

RSpec.describe 'As a user, I want to add activities and sets to a session' do
  it 'allows a user to create a session with activities and sets, and adds it to the main tracker' do
    main = Main.new
    session = Session.new('Leg Day')
    activity = Activity.new('Squats', 'lbs')
    workout_set = WorkoutSet.new(225, 10, 6)

    activity.add_set(workout_set)
    session.add_activity(activity)
    main.add_session(session)

    expect(main.sessions.length).to eq(1)
    expect(main.sessions.first.name).to eq('Leg Day')

    expect(main.records['Squats']).to eq(225)
  end

  it 'returns an error and prevents saving an activity when invalid weights are entered' do
    expect do
      WorkoutSet.new(-225, 10, 6)
    end.to raise_error(ArgumentError, 'Weight cannot be negative')
  end
end

RSpec.describe 'As a user, I want to add sessions to a tracker so I can keep track of all my workouts.' do
  it 'allows a user to start a new session when a valid name is entered' do
    main = Main.new

    session = Session.new('Upper Body')

    main.add_session(session)

    expect(main.sessions.length).to eq(1)
    expect(main.sessions.first.name).to eq('Upper Body')
  end

  it 'returns an error and prevents starting a session when a valid name is not entered' do
    main = Main.new

    expect do
      invalid_session = Session.new('')
      main.add_session(invalid_session)
    end.to raise_error(ArgumentError, 'Name cannot be empty')

    expect(main.sessions.length).to eq(0)
  end
end

RSpec.describe 'As a user, I want to track and view my fitness goals' do
  it 'allows a user to view completed and incomplete goals separately' do
    main = Main.new

    goal1 = Goal.new('Bench Press', 200)
    goal2 = Goal.new('Squat', 315)

    expect { main.view_completed_goals }.to output("").to_stdout

    goal1.toggle_completed 

    main.add_goal(goal1)
    main.add_goal(goal2)

    expect { main.view_completed_goals }.to output("Bench Press\nTarget: 200 lbs\n").to_stdout

    expect { main.view_incomplete_goals }.to output("Squat\nTarget: 315 lbs\n").to_stdout
  end
end
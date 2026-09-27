# frozen_string_literal: true

require 'spec_helper'
require 'main'
require 'session'
require 'activity'
require 'workout_set'
require 'goal'
require 'interface'


RSpec.describe 'As a user, I want to add activities and sets to a session' do
  def queue_console_input(interface, inputs)
    answers = inputs.dup
    allow(interface).to receive(:gets) { answers.shift }
  end

  it 'allows a user to create a session, add an activity, and add a set' do
    main = Main.new
    interface = Interface.allocate
    interface.instance_variable_set(:@main, main)
    allow(main).to receive(:save)

    queue_console_input(interface, [
      '1', 'Leg Day',
      '1', 'Squats',
      '1', '225', '10', '6',
      'exit'
    ])

    expect { interface.start }.to output.to_stdout

    session = main.sessions.first
    activity = session.activities.first
    workout_set = activity.sets.first

    expect(session.name).to eq('Leg Day')
    expect(activity.name).to eq('Squats')
    expect(workout_set.weight).to eq(225)
    expect(workout_set.reps).to eq(10)
    expect(workout_set.rpe).to eq(6)
  end

  it 'handles an invalid menu choice' do
    main = Main.new
    interface = Interface.allocate
    interface.instance_variable_set(:@main, main)
    allow(main).to receive(:save)

    queue_console_input(interface, [
      'bad',
      '1', 'Leg Day',
      'exit'
    ])

    expect { interface.start }.to output.to_stdout

    expect(main.sessions.first.name).to eq('Leg Day')
  end

  it 'creates and completes a goal, then displays completed goals and records' do
    main = Main.new
    interface = Interface.allocate
    interface.instance_variable_set(:@main, main)
    allow(main).to receive(:save)

    queue_console_input(interface, [
      '3', '1', '2',
      '3', '', 'Bench Press', '', '0', '200', '2', '4',
      '1', 'Chest', '1', 'Bench Press', '1', '200', '5', '',
      '2', '3', '3',
      '3', '1', '2', '4', '4', 'bad', '1', '0'
    ])

    expect { interface.start }.to output.to_stdout

    expect(main.goals.first.completed).to be(true)
    expect(main.records['Bench Press']).to eq(200.0)
  end

  it 'user creates a session with activities and sets, and adds it to the main tracker' do
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

  it 'returns an error when invalid weights are entered to activity set' do
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

    expect { main.view_completed_goals }.to output('').to_stdout

    goal1.toggle_completed

    main.add_goal(goal1)
    main.add_goal(goal2)

    expect { main.view_completed_goals }.to output("Bench Press\nTarget: 200 lbs\n").to_stdout

    expect { main.view_incomplete_goals }.to output("Squat\nTarget: 315 lbs\n").to_stdout
  end
end

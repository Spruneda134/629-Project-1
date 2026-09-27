# frozen_string_literal: true

require 'spec_helper'
require 'main'
require 'session'
require 'activity'
require 'workout_set'
require 'goal'
require 'tmpdir'

RSpec.describe Main do
  # save/load go to a throwaway test.json so specs never touch data/tracker.json
  around do |example|
    Dir.mktmpdir do |dir|
      @save_path = File.join(dir, 'test.json')
      example.run
    end
  end

  it 'save sessions after quitting' do
    tracker = Main.new

    session = Session.new('Chest')
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)
    tracker.add_session(session)

    session2 = Session.new('Legs')
    squat = Activity.new('Squat')
    squat.add_set(WorkoutSet.new(315, 5))
    session2.add_activity(squat)
    tracker.add_session(session2)

    tracker.save(@save_path)

    tracker2 = Main.new
    tracker2.load(@save_path)

    expect(tracker2.sessions[0].name).to eq('Chest')
    expect(tracker2.sessions[0].activities[0].name).to eq('Bench press')
    expect(tracker2.sessions[0].activities[0].sets[0].weight).to eq(165)
    expect(tracker2.sessions[0].activities[0].sets[0].reps).to eq(5)

    expect(tracker2.sessions[1].name).to eq('Legs')
    expect(tracker2.sessions[1].activities[0].name).to eq('Squat')
    expect(tracker2.sessions[1].activities[0].sets[0].weight).to eq(315)
    expect(tracker2.sessions[1].activities[0].sets[0].reps).to eq(5)
  end

  it 'save goals after quitting' do
    tracker = Main.new
    goal = Goal.new('Bench Press', 250)
    tracker.add_goal(goal)
    tracker.save(@save_path)

    tracker2 = Main.new
    tracker2.load(@save_path)
    goal2 = tracker2.goals[0]

    expect(goal2.name).to eq('Bench Press')
    expect(goal2.target).to eq(250)
    expect(goal2.completed).to eq(false)
    expect(goal2.date).to be_a(Time)
  end

  it 'save records after quitting' do
    tracker = Main.new

    session = Session.new('Chest')
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)
    tracker.add_session(session)
    session2 = Session.new('Legs')
    squat = Activity.new('Squat')
    squat.add_set(WorkoutSet.new(315, 5))
    session2.add_activity(squat)
    tracker.add_session(session2)
    tracker.save(@save_path)

    tracker2 = Main.new
    tracker2.load(@save_path)

    expect(tracker2.records['Bench press']).to eq(165)
    expect(tracker2.records['Squat']).to eq(315)
  end

  it 'unsaved sessions are not saved' do
    tracker = Main.new

    session = Session.new('Chest')
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)
    tracker.add_session(session)
    tracker.save(@save_path)

    # added after the save, so it should not come back
    session2 = Session.new('Legs')
    squat = Activity.new('Squat')
    squat.add_set(WorkoutSet.new(315, 5))
    session2.add_activity(squat)
    tracker.add_session(session2)

    tracker2 = Main.new
    tracker2.load(@save_path)

    expect(tracker2.sessions[0].name).to eq('Chest')
    expect(tracker2.sessions.length).to eq(1)
    expect(tracker2.records.keys).to eq(['Bench press'])
  end
end

# frozen_string_literal: true

require 'main'
require 'report'
require 'session'
require 'activity'
require 'workout_set'

RSpec.describe Report do
  it 'create a report with an existing activity name' do
    tracker = Main.new

    session = Session.new('Chest')
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)
    tracker.add_session(session)

    report = tracker.create_activity_report('Bench press')
    expect(report).to be_a(Report)
    expect(report.activity_name).to eq('Bench press')
  end

  it 'create a report with non-existing activity name' do
    tracker = Main.new

    expect do
      tracker.create_activity_report('Bench press')
    end.to raise_error(ArgumentError)
  end

  it 'report correct PR' do
    tracker = Main.new

    # Create a chest session
    session = Session.new('Chest')
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)
    tracker.add_session(session)

    report = tracker.create_activity_report('Bench press')
    expect(report.personal_record).to eq(165)
  end

  it 'report correct date for the PR' do
    tracker = Main.new

    # add multiple chest sessions
    past_time = Time.new(2001, 9, 11)
    session = Session.new('Chest', past_time)
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)
    tracker.add_session(session)

    session = Session.new('Chest')
    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(145, 5))
    session.add_activity(bench)
    tracker.add_session(session)

    report = tracker.create_activity_report('Bench press')
    expect(report.pr_date).to eq(past_time)
  end

  it 'view activity report shows PR, time since PR, and session table' do
    tracker = Main.new

    [['Chest Day', Time.new(2026, 8, 29), 165],
     ['Push', Time.new(2026, 9, 12), 185],
     ['Upper Body', Time.new(2026, 9, 19), 180]].each do |name, date, weight|
      session = Session.new(name, date)
      bench = Activity.new('Bench press')
      bench.add_set(WorkoutSet.new(weight - 20, 8))
      bench.add_set(WorkoutSet.new(weight, 3))
      session.add_activity(bench)
      tracker.add_session(session)
    end
    allow(Time).to receive(:now).and_return(Time.new(2026, 9, 26))

    expect do
      tracker.view_activity_report('Bench press')
    end.to output(<<~REPORT).to_stdout
      Bench press Report
      ------------------
      PR: 185 lbs (set on 2026-09-12)
      Time since last PR: 14 days

      Date        Session     Max Weight
      ----------  ----------  ----------
      2026-08-29  Chest Day   165 lbs
      2026-09-12  Push        185 lbs     *PR
      2026-09-19  Upper Body  180 lbs
    REPORT
  end

  it 'view activity report for a manually added PR' do
    tracker = Main.new
    tracker.add_record('Squat', 225)

    expect do
      tracker.view_activity_report('Squat')
    end.to output(<<~REPORT).to_stdout
      Squat Report
      ------------
      PR: 225 lbs (added manually)
      Time since last PR: N/A
    REPORT
  end
end

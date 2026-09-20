require 'record'
require 'debug'
require 'main'
require 'session'
require 'workout_set'

## Happy Paths

# checks that view all records match the expectation.
RSpec.describe Record do
  it "view all records" do
    tracker = Main.new
    session = Session.new

    bench = Activity.new('Bench press')
    bench.add_set(WorkoutSet.new(165, 5))
    session.add_activity(bench)

    squat = Activity.new('Squat')
    squat.add_set(WorkoutSet.new(225, 3))
    session.add_activity(squat)

    tracker.add_session(session)

    expect{
      tracker.view_all_records()
    }.to output("Bench press: 165\nSquat: 225\n").to_stdout
  end
end


# checks adding new activity updates the PR.
RSpec.describe Record do
  it "update new record" do
    tracker = Main.new
    
    session_1 = Session.new
    bench_1 = Activity.new('Bench press')
    bench_1.add_set(WorkoutSet.new(165, 5))
    session_1.add_activity(bench_1)
    
    session_2 = Session.new
    bench_2 = Activity.new('Bench press')
    bench_2.add_set(WorkoutSet.new(175, 5))
    session_2.add_activity(bench_2)

    tracker.add_session(session_1)
    tracker.add_session(session_2)

    expect{
      tracker.view_all_records()
    }.to output("Bench press: 175\n").to_stdout
  end
end

# Checks that manually adding new PR without activity works for those with experience.
RSpec.describe Record do
  it "manually add record" do
    tracker = Main.new
    
    tracker.add_record("Bench press", 225)

    session_1 = Session.new
    bench_1 = Activity.new('Bench press')
    bench_1.add_set(WorkoutSet.new(165, 5))
    session_1.add_activity(bench_1)
    tracker.add_session(session_1)

    expect{
      tracker.view_all_records()
    }.to output("Bench press: 225\n").to_stdout
  end
end


## Sad Path
# If an activity name exists, then we get the PR by name.
# If an activity name doesn't exist then we raise an error.
RSpec.describe Record do
  it "gets personal record by activity name" do
    tracker = Main.new
    
    session_1 = Session.new
    bench_1 = Activity.new('Bench press')
    bench_1.add_set(WorkoutSet.new(165, 5))
    session_1.add_activity(bench_1)
    tracker.add_session(session_1)

    expect{
      tracker.view_record("Bench press")
    }.to output("Bench press: 165\n").to_stdout

    expect{
      tracker.view_record("Shoulder press")
    }.to raise_error(ArgumentError), "Activity does not exist in the records."
  end
end

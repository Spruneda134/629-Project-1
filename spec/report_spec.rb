require 'report'
require 'session'
require 'activity'

RSpec.describe Report do
  it 'make a report with a valid name' do
    report = Report.new('Bench press')

    expect(report.activityName).to eq('Bench press')

  end

  it 'make a report with an existing activity name' do
    report = Report.new('Bench press')

    session = Session.new('Arm Day')
    session.add_activity(Activity.new('Bench press'))

    expect(session.activities[0].name).to eq(report.activityName)
  end

#   it 'make a report that grabs all existing activities' do
#     report = Report.new('Bench press')

#     session = Session.new('Chest Day')
#     session.add_activity(Activity.new('Bench press'))
#     session.activities[0].add_set(WorkoutSet.new(165, 5))

#     session.add_activity(Activity.new('Bench press'))
#     session.activities[0].add_set(WorkoutSet.new(175, 7))

#     expect(session.activities[0].name).to eq(report.activityName)
#   end





  context 'make a report with invalid attributes' do
    it 'raises an error when no activity name is entered' do
      expect { Report.new('') }.to raise_error(ArgumentError, 'Activity name cannot be nil or empty')
    end

    it 'raises an error when the activity does not exist' do
      expect { Report.new('Non-existent Activity') }.to raise_error(ArgumentError, 'Activity does not exist in the records.')
    end

  end

end

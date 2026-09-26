require 'spec_helper'
require 'main'
require 'goal'

RSpec.describe Main do
  it 'start app with empty collections (sessions, goals, records)' do
    main = Main.new

    expect(main.sessions.length).to eq(0)
    expect(main.goals.length).to eq(0)
    expect(main.records.length).to eq(0)
  end
end

RSpec.describe Main do
  context 'with valid attributes' do
    it 'add a session to the app' do
      main = Main.new

      # temp session array
      session = double('Session', name: 'Arm Day', activities: [])

      main.add_session(session)

      expect(main.sessions).to include(session)
    end
  end

  context 'with invalid attributes' do
    it 'raises an error when session name is empty' do
      main = Main.new
      expect do
        main.add_session(double('Session', activities: [], name: ''))
      end.to raise_error(ArgumentError, 'Name cannot be empty')
    end

    it 'raises an error when session name already exists' do
          main = Main.new

          first_session = double('Session', name: 'Leg Day', activities: [])
          main.add_session(first_session)

          expect do
            duplicate_session = double('Session', name: 'Leg Day', activities: [])
            main.add_session(duplicate_session)
          end.to raise_error(ArgumentError, 'Session name already exists')
        end
      end
    end

RSpec.describe Main do
  it 'view sessions in app' do
    main = Main.new

    # temp sessions
    session1 = double('Session', name: 'Arm Day', activities: [], to_s: 'Arm Day')
    session2 = double('Session', name: 'Leg Day', activities: [], to_s: 'Leg Day')

    main.add_session(session1)
    main.add_session(session2)

    expect { main.view_sessions }.to output(
      "Arm Day\nLeg Day\n"
    ).to_stdout
  end
end

RSpec.describe Main do
  context 'with valid attributes' do
    it 'adds and views goals in the app' do
      main = Main.new

      name = 'Bench Press'
      target = 200
      goal1 = Goal.new(name, target)
      
      main.add_goal(goal1)

      expect { main.view_goals }.to output(
        "Bench Press\nTarget: 200 lbs\n"
      ).to_stdout
      expect { main.view_incomplete_goals }.to output(
        "Bench Press\nTarget: 200 lbs\n"
      ).to_stdout
      goal1.toggle_completed
      expect { main.view_completed_goals }.to output(
        "Bench Press\nTarget: 200 lbs\n"
      ).to_stdout
      expect { main.view_incomplete_goals }.to output(
        ""
      ).to_stdout
    end
  end

  context 'with invalid attributes' do
    it 'raises an error when goal name is empty' do
      main = Main.new
      expect do
        main.add_goal(Goal.new('', 100))
      end.to raise_error(ArgumentError, 'Name cannot be empty')
    end

    it 'raises an error when goal target is negative' do
      main = Main.new
      expect do
        main.add_goal(Goal.new('Bench Press', -100))
      end.to raise_error(ArgumentError, 'Target cannot be negative')
    end
  end
end
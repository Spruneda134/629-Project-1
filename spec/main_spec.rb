require 'main'

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
      session = double("Session", name: "Arm Day", activities: [])

      main.add_session(session)

      expect(main.sessions).to include(session)
    end
  end

  context 'with invalid attributes' do
    it 'raises an error when session name is empty' do
      main = Main.new
      expect { main.add_session(double("Session", activities: [], name: "")) }.to raise_error(ArgumentError, "Name cannot be empty")
    end
  end
end

RSpec.describe Main do

  it 'view sessions in app' do
    main = Main.new

    # temp sessions
    session1 = double("Session", name: "Arm Day", activities: [], to_s: "Arm Day")
    session2 = double("Session",name: "Leg Day", activities: [], to_s: "Leg Day")

    main.add_session(session1)
    main.add_session(session2)

    expect { main.view_sessions }.to output(
      "Arm Day\nLeg Day\n"
    ).to_stdout
  end
end
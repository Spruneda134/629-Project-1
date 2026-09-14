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

  it 'add a session to the app' do
    main = Main.new

    main.add_session("Arm Day")

    expect(main.sessions).to include("Arm Day")
  end
end

RSpec.describe Main do

  it 'view sessions in app' do
    main = Main.new
    main.add_session("Arm Day")
    main.add_session("Leg Day")

    expect { main.view_sessions }.to output(
      "Arm Day\nLeg Day\n"
    ).to_stdout
  end
end
require 'main'

RSpec.describe Main do
  it 'start app with empty collections (sessions, goals, records)' do
    main = Main.new

    expect(main.sessions.length).to eq(0)
    expect(main.goals.length).to eq(0)
    expect(main.records.length).to eq(0)
  end
end

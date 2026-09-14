require 'main'

RSpec.describe Main do
  it 'start with an empty app with no sessions' do
    expect(Main.new.sessions.length).to eq(0)
  end
end

RSpec.describe Main do
  it 'start with an empty app with no goals' do
    expect(Main.new.goals.length).to eq(0)
  end
end

RSpec.describe Main do
  it 'start with an empty app with no sessions' do
    expect(Main.new.sessions.length).to eq(0)
  end
end
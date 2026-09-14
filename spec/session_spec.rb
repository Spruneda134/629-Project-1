require 'session'

RSpec.describe Session do
  it 'create a session with an empty activity list and a valid name and date' do
    session = Session.new("Leg Day")

    expect(session.name).to eq("Leg Day")
    expect(session.date).to be_a(Time)
    expect(session.activities.length).to eq(0)
  end
end
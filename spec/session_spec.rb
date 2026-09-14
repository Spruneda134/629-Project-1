require 'session'

RSpec.describe Session do
  it 'create a session with an empty activity list and a valid name and date' do
    session = Session.new("Leg Day")

    expect(session.name).to eq("Leg Day")
    expect(session.date).to be_a(Time)
    expect(session.activities.length).to eq(0)
  end
end

RSpec.describe Session do
  it 'edit session name' do
    session = Session.new("Arm Day")

    expect(session.name).to eq("Arm Day")
    session.edit_name("Chest Day")

    expect(session.name).to eq("Chest Day")
  end
end

RSpec.describe Session do
  it 'add an activity to session' do
    session = Session.new("Arm Day")

  end
end

RSpec.describe Session do

  it 'add an activity to session' do
    session = Session.new("Arm Day")

    session.add_activity("Bicep Curls")

    expect(session.activities).to include("Bicep Curls")
  end
end

RSpec.describe Session do

  it 'view activities in session' do
    session = Session.new("Arm Day")

    session.add_activity("Bicep Curls")
    session.add_activity("Tricep Extensions")

    expect { session.view_activities }.to output(
      "Bicep Curls\nTricep Extensions\n"
    ).to_stdout
  end
end
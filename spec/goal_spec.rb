require 'goal'

RSpec.describe Goal do
    it 'create a goal with a valid name, target, date, and an incomplete status' do
        goal = Goal.new("Bench Press", 250)

        expect(goal.name).to eq("Bench Press")
        expect(goal.target).to eq(250)
        expect(goal.completed).to eq(false)
        expect(goal.date).to be_a(Time)
    end
end

RSpec.describe Goal do
  it 'edit goal name' do
    goal = Goal.new("Bench Press", 250)

    expect(goal.name).to eq("Bench Press")
    goal.edit_name("Squat")

    expect(goal.name).to eq("Squat")
  end
end

RSpec.describe Goal do
  it 'edit goal target' do
    goal = Goal.new("Bench Press", 250)

    expect(goal.target).to eq(250)
    goal.edit_target(300)

    expect(goal.target).to eq(300)
  end
end

RSpec.describe Goal do
  it 'toggle goal completed status' do
    goal = Goal.new("Bench Press", 250)

    expect(goal.completed).to eq(false)
    goal.toggle_completed()

    expect(goal.completed).to eq(true)
  end
end
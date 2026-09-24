require 'spec_helper'
require 'goal'

RSpec.describe Goal do
  context 'with valid attributes' do
    it 'create a goal with a valid name, target, date, and an incomplete status' do
        goal = Goal.new("Bench Press", 250)

        expect(goal.name).to eq("Bench Press")
        expect(goal.target).to eq(250)
        expect(goal.completed).to eq(false)
        expect(goal.date).to be_a(Time)
    end
  end

  context 'with invalid attributes' do
  
    it 'raises an error when name is empty' do
      expect { Goal.new("", 250) }.to raise_error(ArgumentError, "Name cannot be empty")
    end

    it 'raises an error when target is not an integer' do
      expect { Goal.new("Bench Press", "a lot") }.to raise_error(ArgumentError, "Target must be an integer")
    end

    it 'raises an error when target is negative' do
      expect { Goal.new("Bench Press", -250) }.to raise_error(ArgumentError, "Target cannot be negative")
    end

  end

end

RSpec.describe Goal do

  context 'with valid attributes' do
    it 'edit goal name' do
      goal = Goal.new("Bench Press", 250)

      expect(goal.name).to eq("Bench Press")
      goal.edit_name("Squat")

      expect(goal.name).to eq("Squat")
    end
  end

  context 'with invalid attributes' do
    it 'raises an error when new name is empty' do
      goal = Goal.new("Bench Press", 250)
      expect { goal.edit_name("") }.to raise_error(ArgumentError, "Name cannot be empty")
    end
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
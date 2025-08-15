# frozen_string_literal: true

RSpec.describe RobotSimulator::Core::Robot do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  subject(:robot) { described_class.new(grid) }

  describe '#initialize' do
    it 'creates a robot with the specified grid' do
      expect(robot.grid).to eq(grid)
    end

    it 'starts with nil position and direction' do
      expect(robot.x).to be_nil
      expect(robot.y).to be_nil
      expect(robot.facing).to be_nil
    end

    it 'starts as not placed' do
      expect(robot.placed?).to be false
    end
  end

  describe '#execute_movement' do
    let(:movement) { instance_double('Movement') }

    it 'delegates execution to the movement' do
      expect(movement).to receive(:execute)
      robot.execute_movement(movement)
    end
  end

  describe '#update_position' do
    it 'updates the robot position and direction' do
      robot.update_position(2, 3, 'NORTH')
      expect(robot.x).to eq(2)
      expect(robot.y).to eq(3)
      expect(robot.facing).to eq('NORTH')
    end

    it 'marks the robot as placed' do
      expect { robot.update_position(0, 0, 'NORTH') }
        .to change { robot.placed? }.from(false).to(true)
    end
  end
end

RSpec.describe RobotSimulator::Core::DotNewRobot do
  subject(:robot) { described_class.new }

  it 'initializes with a 5x5 grid' do
    expect(robot.grid.size).to eq(5)
  end
end 
# frozen_string_literal: true

require_relative 'command_shared_examples'

RSpec.describe RobotSimulator::Commands do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }

  describe RobotSimulator::Commands::MoveCommand do
    subject(:command) { described_class.new(robot) }

    before do
      @movement = instance_double(RobotSimulator::Movements::Forward)
      allow(RobotSimulator::Movements::Forward).to receive(:new)
        .with(robot)
        .and_return(@movement)
    end

    it_behaves_like 'a robot command'
  end

  describe RobotSimulator::Commands::LeftCommand do
    subject(:command) { described_class.new(robot) }

    before do
      @movement = instance_double(RobotSimulator::Movements::Rotate)
      allow(RobotSimulator::Movements::Rotate).to receive(:new)
        .with(robot, -1)
        .and_return(@movement)
    end

    it_behaves_like 'a robot command'
  end

  describe RobotSimulator::Commands::RightCommand do
    subject(:command) { described_class.new(robot) }

    before do
      @movement = instance_double(RobotSimulator::Movements::Rotate)
      allow(RobotSimulator::Movements::Rotate).to receive(:new)
        .with(robot, 1)
        .and_return(@movement)
    end

    it_behaves_like 'a robot command'
  end
end 
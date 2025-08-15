# frozen_string_literal: true

require_relative 'command_shared_examples'

RSpec.describe RobotSimulator::Commands do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }

  describe RobotSimulator::Commands::PlaceCommand do
    subject(:command) { described_class.new(robot, x, y, facing) }
    let(:x) { 2 }
    let(:y) { 3 }
    let(:facing) { 'NORTH' }

    before do
      @movement = instance_double(RobotSimulator::Movements::Place)
      allow(RobotSimulator::Movements::Place).to receive(:new)
        .with(robot, x, y, facing)
        .and_return(@movement)
    end

    it_behaves_like 'a robot command'
  end

  describe RobotSimulator::Commands::ReportCommand do
    subject(:command) { described_class.new(robot) }

    before do
      @movement = instance_double(RobotSimulator::Movements::Report)
      allow(RobotSimulator::Movements::Report).to receive(:new)
        .with(robot)
        .and_return(@movement)
    end

    it_behaves_like 'a robot command'
  end
end 
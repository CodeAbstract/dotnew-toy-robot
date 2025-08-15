# frozen_string_literal: true

RSpec.shared_examples 'a robot command' do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }

  it 'delegates execution to a movement' do
    expect(@movement).to receive(:execute).once
    command.execute
  end

  it 'delegates execution through the robot' do
    allow(@movement).to receive(:execute)
    expect(robot).to receive(:execute_movement).with(@movement).once
    command.execute
  end
end 
# frozen_string_literal: true

RSpec.describe 'Robot Movement Integration' do
  let(:robot) { RobotSimulator::Core::DotNewRobot.new }
  let(:place_command) { RobotSimulator::Commands::PlaceCommand.new(robot, 2, 2, 'NORTH') }
  let(:move_command) { RobotSimulator::Commands::MoveCommand.new(robot) }
  let(:left_command) { RobotSimulator::Commands::LeftCommand.new(robot) }
  let(:right_command) { RobotSimulator::Commands::RightCommand.new(robot) }
  let(:report_command) { RobotSimulator::Commands::ReportCommand.new(robot) }

  describe 'movement sequence' do
    it 'handles a sequence of valid commands' do
      place_command.execute
      move_command.execute
      right_command.execute
      move_command.execute
      expect(report_command.execute).to eq('3,3,EAST')
    end

    it 'maintains state after invalid moves' do
      place_command.execute
      expect {
        RobotSimulator::Commands::PlaceCommand.new(robot, 5, 5, 'NORTH').execute
      }.to raise_error(RobotSimulator::Errors::InvalidPositionError)
      expect(report_command.execute).to eq('2,2,NORTH')
    end

    it 'handles complex movement patterns' do
      RobotSimulator::Commands::PlaceCommand.new(robot, 1, 2, 'EAST').execute
      move_command.execute
      move_command.execute
      left_command.execute
      move_command.execute
      expect(report_command.execute).to eq('3,3,NORTH')
    end
  end

  describe 'rotation' do
    before { place_command.execute }

    it 'completes full rotation to the right' do
      expect(report_command.execute).to eq('2,2,NORTH')
      right_command.execute
      expect(report_command.execute).to eq('2,2,EAST')
      right_command.execute
      expect(report_command.execute).to eq('2,2,SOUTH')
      right_command.execute
      expect(report_command.execute).to eq('2,2,WEST')
      right_command.execute
      expect(report_command.execute).to eq('2,2,NORTH')
    end

    it 'completes full rotation to the left' do
      expect(report_command.execute).to eq('2,2,NORTH')
      left_command.execute
      expect(report_command.execute).to eq('2,2,WEST')
      left_command.execute
      expect(report_command.execute).to eq('2,2,SOUTH')
      left_command.execute
      expect(report_command.execute).to eq('2,2,EAST')
      left_command.execute
      expect(report_command.execute).to eq('2,2,NORTH')
    end
  end

  describe 'error handling' do
    it 'prevents moving beyond grid boundaries' do
      RobotSimulator::Commands::PlaceCommand.new(robot, 0, 0, 'SOUTH').execute
      expect { move_command.execute }
        .to raise_error(RobotSimulator::Errors::InvalidPositionError)
    end

    it 'requires placement before other commands' do
      expect { move_command.execute }
        .to raise_error(RobotSimulator::Errors::RobotNotPlacedError)
      expect { report_command.execute }
        .to raise_error(RobotSimulator::Errors::RobotNotPlacedError)
    end

    it 'validates placement coordinates' do
      expect {
        RobotSimulator::Commands::PlaceCommand.new(robot, -1, 0, 'NORTH').execute
      }.to raise_error(RobotSimulator::Errors::InvalidPositionError)
    end

    it 'validates placement direction' do
      expect {
        RobotSimulator::Commands::PlaceCommand.new(robot, 0, 0, 'INVALID').execute
      }.to raise_error(RobotSimulator::Errors::InvalidDirectionError)
    end
  end
end 
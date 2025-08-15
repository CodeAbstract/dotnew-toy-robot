# frozen_string_literal: true

RSpec.describe RobotSimulator::Commands::BaseCommand do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }
  subject(:command) { described_class.new(robot) }

  describe '#execute' do
    it 'raises NotImplementedError' do
      expect { command.execute }.to raise_error(NotImplementedError)
    end
  end
end 
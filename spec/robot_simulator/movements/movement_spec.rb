# frozen_string_literal: true

RSpec.describe RobotSimulator::Movements::Movement do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }
  subject(:movement) { described_class.new(robot) }

  describe '#execute' do
    it 'raises NotImplementedError' do
      expect { movement.execute }.to raise_error(NotImplementedError)
    end
  end

  describe 'validation methods' do
    describe '#validate_position!' do
      context 'with invalid position' do
        it 'raises InvalidPositionError for out of bounds coordinates' do
          expect { movement.send(:validate_position!, 5, 5) }
            .to raise_error(RobotSimulator::Errors::InvalidPositionError)
        end
      end

      context 'with valid position' do
        it 'does not raise error' do
          expect { movement.send(:validate_position!, 0, 0) }.not_to raise_error
        end
      end
    end

    describe '#validate_direction!' do
      context 'with invalid direction' do
        it 'raises InvalidDirectionError' do
          expect { movement.send(:validate_direction!, 'INVALID') }
            .to raise_error(RobotSimulator::Errors::InvalidDirectionError)
        end
      end

      context 'with valid direction' do
        it 'does not raise error' do
          expect { movement.send(:validate_direction!, 'NORTH') }.not_to raise_error
        end
      end
    end

    describe '#ensure_placed!' do
      context 'when robot is not placed' do
        it 'raises RobotNotPlacedError' do
          expect { movement.send(:ensure_placed!) }
            .to raise_error(RobotSimulator::Errors::RobotNotPlacedError)
        end
      end

      context 'when robot is placed' do
        before { robot.update_position(0, 0, 'NORTH') }

        it 'does not raise error' do
          expect { movement.send(:ensure_placed!) }.not_to raise_error
        end
      end
    end
  end
end 
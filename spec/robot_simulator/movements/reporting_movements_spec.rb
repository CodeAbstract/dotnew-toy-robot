# frozen_string_literal: true

RSpec.describe RobotSimulator::Movements do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }

  describe RobotSimulator::Movements::Report do
    subject(:movement) { described_class.new(robot) }

    describe '#execute' do
      context 'when robot is not placed' do
        it 'raises RobotNotPlacedError' do
          expect { movement.execute }
            .to raise_error(RobotSimulator::Errors::RobotNotPlacedError)
        end
      end

      context 'when robot is placed' do
        before { robot.update_position(1, 2, 'EAST') }

        it 'returns current position and direction' do
          expect(movement.execute).to eq('1,2,EAST')
        end

        it 'does not change robot state' do
          expect { movement.execute }.not_to change {
            [robot.x, robot.y, robot.facing]
          }
        end
      end
    end
  end
end 
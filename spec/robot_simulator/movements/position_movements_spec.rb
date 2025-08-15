# frozen_string_literal: true

RSpec.describe RobotSimulator::Movements do
  let(:grid) { RobotSimulator::Core::Grid.new(5) }
  let(:robot) { RobotSimulator::Core::Robot.new(grid) }

  describe RobotSimulator::Movements::Place do
    subject(:movement) { described_class.new(robot, x, y, facing) }
    let(:x) { 2 }
    let(:y) { 3 }
    let(:facing) { 'NORTH' }

    describe '#execute' do
      context 'with valid position and direction' do
        it 'updates robot position and direction' do
          movement.execute
          expect(robot.x).to eq(x)
          expect(robot.y).to eq(y)
          expect(robot.facing).to eq(facing)
        end

        it 'marks robot as placed' do
          expect { movement.execute }
            .to change { robot.placed? }.from(false).to(true)
        end
      end

      context 'with invalid position' do
        let(:x) { 5 }
        let(:y) { 5 }

        it 'raises InvalidPositionError' do
          expect { movement.execute }
            .to raise_error(RobotSimulator::Errors::InvalidPositionError)
        end
      end

      context 'with invalid direction' do
        let(:facing) { 'INVALID' }

        it 'raises InvalidDirectionError' do
          expect { movement.execute }
            .to raise_error(RobotSimulator::Errors::InvalidDirectionError)
        end
      end
    end
  end

  describe RobotSimulator::Movements::Forward do
    subject(:movement) { described_class.new(robot) }

    describe '#execute' do
      context 'when robot is not placed' do
        it 'raises RobotNotPlacedError' do
          expect { movement.execute }
            .to raise_error(RobotSimulator::Errors::RobotNotPlacedError)
        end
      end

      context 'when robot is placed' do
        shared_examples 'moves one step' do |direction, start_x, start_y, end_x, end_y|
          before { robot.update_position(start_x, start_y, direction) }

          it "moves one unit #{direction.downcase}" do
            movement.execute
            expect(robot.x).to eq(end_x)
            expect(robot.y).to eq(end_y)
            expect(robot.facing).to eq(direction)
          end
        end

        it_behaves_like 'moves one step', 'NORTH', 2, 2, 2, 3
        it_behaves_like 'moves one step', 'EAST', 2, 2, 3, 2
        it_behaves_like 'moves one step', 'SOUTH', 2, 2, 2, 1
        it_behaves_like 'moves one step', 'WEST', 2, 2, 1, 2

        context 'when move would be invalid' do
          {
            'NORTH' => [0, 4],
            'EAST'  => [4, 0],
            'SOUTH' => [0, 0],
            'WEST'  => [0, 0]
          }.each do |direction, (start_x, start_y)|
            context "when facing #{direction} at edge" do
              before { robot.update_position(start_x, start_y, direction) }

              it 'raises InvalidPositionError' do
                expect { movement.execute }
                  .to raise_error(RobotSimulator::Errors::InvalidPositionError)
              end
            end
          end
        end
      end
    end
  end

  describe RobotSimulator::Movements::Rotate do
    subject(:movement) { described_class.new(robot, direction) }

    describe '#execute' do
      context 'when robot is not placed' do
        let(:direction) { 1 }

        it 'raises RobotNotPlacedError' do
          expect { movement.execute }
            .to raise_error(RobotSimulator::Errors::RobotNotPlacedError)
        end
      end

      context 'when robot is placed' do
        let(:x) { 2 }
        let(:y) { 3 }

        before { robot.update_position(x, y, initial_facing) }

        context 'rotating right' do
          let(:direction) { 1 }
          {
            'NORTH' => 'EAST',
            'EAST'  => 'SOUTH',
            'SOUTH' => 'WEST',
            'WEST'  => 'NORTH'
          }.each do |from, to|
            context "from #{from}" do
              let(:initial_facing) { from }

              it "rotates to #{to}" do
                movement.execute
                expect(robot.facing).to eq(to)
              end
            end
          end
        end

        context 'rotating left' do
          let(:direction) { -1 }
          {
            'NORTH' => 'WEST',
            'WEST'  => 'SOUTH',
            'SOUTH' => 'EAST',
            'EAST'  => 'NORTH'
          }.each do |from, to|
            context "from #{from}" do
              let(:initial_facing) { from }

              it "rotates to #{to}" do
                movement.execute
                expect(robot.facing).to eq(to)
              end
            end
          end
        end

        context 'position remains unchanged' do
          let(:direction) { 1 }
          let(:initial_facing) { 'NORTH' }

          it 'maintains the same position' do
            movement.execute
            expect(robot.x).to eq(x)
            expect(robot.y).to eq(y)
          end
        end
      end
    end
  end
end 
# frozen_string_literal: true

RSpec.describe RobotSimulator::CommandProcessor do
  let(:robot) { RobotSimulator::Core::DotNewRobot.new }
  subject(:processor) { described_class.new(robot) }

  describe '#process' do
    context 'with valid commands' do
      {
        'MOVE' => RobotSimulator::Commands::MoveCommand,
        'LEFT' => RobotSimulator::Commands::LeftCommand,
        'RIGHT' => RobotSimulator::Commands::RightCommand,
        'REPORT' => RobotSimulator::Commands::ReportCommand
      }.each do |command, command_class|
        context "with #{command} command" do
          it "returns a #{command_class} instance" do
            expect(processor.process(command)).to be_a(command_class)
          end
        end
      end

      context 'with PLACE command' do
        it 'returns a PlaceCommand instance' do
          expect(processor.process('PLACE 0,0,NORTH')).to be_a(RobotSimulator::Commands::PlaceCommand)
        end

        context 'with invalid arguments' do
          it 'raises error for missing arguments' do
            expect { processor.process('PLACE') }
              .to raise_error(RobotSimulator::Errors::InvalidPlaceCommandError)
          end

          it 'raises error for non-integer coordinates' do
            expect { processor.process('PLACE a,b,NORTH') }
              .to raise_error(RobotSimulator::Errors::InvalidPlaceCommandError)
          end
        end
      end

      context 'with special commands' do
        it 'returns :help for HELP command' do
          expect(processor.process('HELP')).to eq(:help)
        end

        it 'returns :exit for EXIT command' do
          expect(processor.process('EXIT')).to eq(:exit)
        end
      end
    end

    context 'with invalid commands' do
      it 'raises error for unknown command' do
        expect { processor.process('INVALID') }
          .to raise_error(RobotSimulator::Errors::InvalidCommandError)
      end

      it 'raises error for nil command' do
        expect { processor.process(nil) }
          .to raise_error(RobotSimulator::Errors::InvalidCommandError)
      end

      it 'raises error for empty command' do
        expect { processor.process('') }
          .to raise_error(RobotSimulator::Errors::InvalidCommandError)
      end
    end
  end
end 
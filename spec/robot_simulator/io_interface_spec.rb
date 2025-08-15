# frozen_string_literal: true

RSpec.describe RobotSimulator::IOInterface do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  subject(:io) { described_class.new(input: input, output: output) }

  before do
    @original_test_env = ENV['TEST']
    ENV['TEST'] = 'true'
  end

  after do
    ENV['TEST'] = @original_test_env
  end

  describe '#read_command' do
    context 'with valid input' do
      before { input.puts("MOVE\n"); input.rewind }

      it 'returns stripped command' do
        expect(io.read_command).to eq('MOVE')
      end
    end

    context 'with EOF' do
      it 'raises IOError' do
        expect { io.read_command }
          .to raise_error(RobotSimulator::Errors::IOError, 'Error during I/O operation: End of input (Ctrl+D)')
      end
    end

    context 'with IO error' do
      before { allow(input).to receive(:gets).and_raise(IOError, 'Read error') }

      it 'raises IOError with message' do
        expect { io.read_command }
          .to raise_error(RobotSimulator::Errors::IOError, 'Error during I/O operation: Failed to read input: Read error')
      end
    end
  end

  describe '#display_welcome' do
    it 'displays welcome message' do
      io.display_welcome
      expect(output.string).to include('=== Robot Simulator ===')
      expect(output.string).to include("Type 'HELP' for available commands")
      expect(output.string).to include("Type 'EXIT' to quit")
    end
  end

  describe '#display_error' do
    let(:error) { RobotSimulator::Errors::RobotError.new('Test error') }

    it 'displays error in red' do
      io.display_error(error)
      expect(output.string).to include("\e[31mTest error\e[0m")
    end
  end

  describe '#display_success' do
    it 'displays message in green' do
      io.display_success('Success')
      expect(output.string).to include("\e[32mSuccess\e[0m")
    end
  end

  describe '#display_warning' do
    it 'displays message in yellow' do
      io.display_warning('Warning')
      expect(output.string).to include("\e[33mWarning\e[0m")
    end
  end

  describe '#display_info' do
    it 'displays message in cyan' do
      io.display_info('Info')
      expect(output.string).to include("\e[36mInfo\e[0m")
    end
  end

  describe '#display_goodbye' do
    it 'displays goodbye message in cyan' do
      io.display_goodbye
      expect(output.string).to include("\e[36m\nGoodbye!\e[0m")
    end
  end
end 
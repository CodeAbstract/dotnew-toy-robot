# frozen_string_literal: true

RSpec.describe RobotSimulator::Config do
  before do
    # Reset grid size before each test
    described_class.instance_variable_set(:@grid_size, nil)
  end

  describe '.grid_size' do
    it 'returns default grid size' do
      expect(described_class.grid_size).to eq(described_class::DEFAULT_GRID_SIZE)
    end
  end

  describe '.grid_size=' do
    context 'with valid size' do
      it 'sets grid size' do
        described_class.grid_size = 7
        expect(described_class.grid_size).to eq(7)
      end
    end

    context 'with invalid size' do
      it 'raises error for non-integer' do
        expect { described_class.grid_size = 'invalid' }
          .to raise_error(ArgumentError)
      end

      it 'raises error for too small size' do
        expect { described_class.grid_size = 0 }
          .to raise_error(ArgumentError)
      end

      it 'raises error for too large size' do
        expect { described_class.grid_size = 11 }
          .to raise_error(ArgumentError)
      end
    end
  end
end 
# frozen_string_literal: true

RSpec.describe RobotSimulator::Core::Grid do
  subject(:grid) { described_class.new(5) }

  describe '#valid_position?' do
    context 'with valid positions' do
      it 'returns true for positions within grid boundaries' do
        expect(grid.valid_position?(0, 0)).to be true
        expect(grid.valid_position?(4, 4)).to be true
        expect(grid.valid_position?(2, 3)).to be true
      end
    end

    context 'with invalid positions' do
      it 'returns false for negative coordinates' do
        expect(grid.valid_position?(-1, 0)).to be false
        expect(grid.valid_position?(0, -1)).to be false
      end

      it 'returns false for coordinates beyond grid size' do
        expect(grid.valid_position?(5, 0)).to be false
        expect(grid.valid_position?(0, 5)).to be false
      end

      it 'returns false for non-integer coordinates' do
        expect(grid.valid_position?(1.5, 2)).to be false
        expect(grid.valid_position?(2, 2.5)).to be false
        expect(grid.valid_position?('1', 2)).to be false
      end
    end
  end

  describe '#dimensions' do
    it 'returns the grid dimensions as a string' do
      expect(grid.dimensions).to eq('5x5')
    end
  end
end 
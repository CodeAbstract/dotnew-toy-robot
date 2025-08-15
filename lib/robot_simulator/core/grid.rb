# frozen_string_literal: true

module RobotSimulator
  module Core
    # Represents a square grid with specified dimensions
    class Grid
      attr_reader :size

      def initialize(size)
        @size = size
      end

      # Checks if a position is valid within the grid
      # @param x [Integer] x-coordinate
      # @param y [Integer] y-coordinate
      # @return [Boolean] true if position is valid
      def valid_position?(x, y)
        return false unless x.is_a?(Integer) && y.is_a?(Integer)

        x.between?(0, size - 1) && y.between?(0, size - 1)
      end

      # Returns the dimensions of the grid as a string
      # @return [String] grid dimensions
      def dimensions
        "#{size}x#{size}"
      end
    end
  end
end 
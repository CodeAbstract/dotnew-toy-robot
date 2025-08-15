# frozen_string_literal: true

module RobotSimulator
  # Configuration management for the robot simulator
  class Config
    DEFAULT_GRID_SIZE = 5
    MINIMUM_GRID_SIZE = 1
    MAXIMUM_GRID_SIZE = 10

    class << self
      def grid_size
        @grid_size ||= DEFAULT_GRID_SIZE
      end

      def grid_size=(size)
        validate_grid_size!(size)
        @grid_size = size
      end

      private

      def validate_grid_size!(size)
        unless size.is_a?(Integer) && size.between?(MINIMUM_GRID_SIZE, MAXIMUM_GRID_SIZE)
          raise ArgumentError, "Grid size must be between #{MINIMUM_GRID_SIZE} and #{MAXIMUM_GRID_SIZE}"
        end
      end
    end
  end
end 
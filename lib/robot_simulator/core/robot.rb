# frozen_string_literal: true

module RobotSimulator
  module Core
    # Base class for robot implementations
    class Robot
      DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

      attr_reader :x, :y, :facing, :grid

      def initialize(grid)
        @grid = grid
        @x = nil
        @y = nil
        @facing = nil
        @placed = false
      end

      # Executes a movement on the robot
      # @param movement [Movement] the movement to execute
      # @return [String, nil] result of the movement if any
      def execute_movement(movement)
        movement.execute
      end

      # Updates the robot's position and direction
      # @param x [Integer] new x-coordinate
      # @param y [Integer] new y-coordinate
      # @param facing [String] new direction
      def update_position(x, y, facing)
        @x = x
        @y = y
        @facing = facing
        @placed = true
      end

      # Checks if the robot has been placed on the grid
      # @return [Boolean] true if robot is placed, false otherwise
      def placed?
        @placed
      end
    end

    # Implementation of a robot for a 5x5 grid
    class DotNewRobot < Robot
      GRID_SIZE = 5

      def initialize
        super(Grid.new(GRID_SIZE))
      end
    end
  end
end 
# frozen_string_literal: true

module RobotSimulator
  module Errors
    # Base error class for all robot-related errors
    class RobotError < StandardError
      def user_message
        message
      end
    end

    # Error for invalid robot positions
    class InvalidPositionError < RobotError
      def initialize(x, y, grid_size)
        super("Position (#{x},#{y}) is outside the #{grid_size}x#{grid_size} grid")
      end
    end

    # Error for invalid directions
    class InvalidDirectionError < RobotError
      def initialize(direction, valid_directions)
        super("Invalid direction: #{direction}. Must be one of: #{valid_directions.join(', ')}")
      end
    end

    # Error when robot is not placed
    class RobotNotPlacedError < RobotError
      def initialize
        super('Robot must be placed on the grid first')
      end
    end

    # Error for invalid command format
    class InvalidCommandError < RobotError
      def initialize(command = nil)
        msg = if command
                "Invalid command: #{command}. Type 'HELP' for available commands."
              else
                "Invalid command format. Type 'HELP' for available commands."
              end
        super(msg)
      end
    end

    # Error for invalid place command format
    class InvalidPlaceCommandError < RobotError
      def initialize
        super("Invalid PLACE command. Format: PLACE X,Y,DIRECTION")
      end
    end

    # Error for I/O operations
    class IOError < RobotError
      def initialize(operation)
        super("Error during I/O operation: #{operation}")
      end
    end
  end
end 
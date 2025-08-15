# frozen_string_literal: true

module RobotSimulator
  module Movements
    # Base movement strategy
    class Movement
      def initialize(robot)
        @robot = robot
      end

      def execute
        raise NotImplementedError, 'Movement must implement execute method'
      end

      protected

      def validate_position!(x, y)
        unless @robot.grid.valid_position?(x, y)
          raise Errors::InvalidPositionError.new(x, y, @robot.grid.size)
        end
      end

      def validate_direction!(facing)
        unless Core::Robot::DIRECTIONS.include?(facing)
          raise Errors::InvalidDirectionError.new(facing, Core::Robot::DIRECTIONS)
        end
      end

      def ensure_placed!
        raise Errors::RobotNotPlacedError.new unless @robot.placed?
      end
    end
  end
end 
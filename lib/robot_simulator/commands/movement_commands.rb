# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Moves the robot forward
    class MoveCommand < BaseCommand
      def initialize(robot)
        super
        @movement = Movements::Forward.new(robot)
      end

      def execute
        @robot.execute_movement(@movement)
      end
    end

    # Rotates the robot left
    class LeftCommand < BaseCommand
      def initialize(robot)
        super
        @movement = Movements::Rotate.new(robot, -1)
      end

      def execute
        @robot.execute_movement(@movement)
      end
    end

    # Rotates the robot right
    class RightCommand < BaseCommand
      def initialize(robot)
        super
        @movement = Movements::Rotate.new(robot, 1)
      end

      def execute
        @robot.execute_movement(@movement)
      end
    end
  end
end 
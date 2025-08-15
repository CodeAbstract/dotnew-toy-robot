# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Places the robot at a specific position
    class PlaceCommand < BaseCommand
      def initialize(robot, x, y, facing)
        super(robot)
        @movement = Movements::Place.new(robot, x, y, facing)
      end

      def execute
        @robot.execute_movement(@movement)
      end
    end

    # Reports the robot's position
    class ReportCommand < BaseCommand
      def initialize(robot)
        super
        @movement = Movements::Report.new(robot)
      end

      def execute
        @robot.execute_movement(@movement)
      end
    end
  end
end 
# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Base command class
    class BaseCommand
      def initialize(robot)
        @robot = robot
      end

      def execute
        raise NotImplementedError, 'Command must implement execute method'
      end
    end
  end
end 
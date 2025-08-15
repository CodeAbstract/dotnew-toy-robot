# frozen_string_literal: true

module RobotSimulator
  module Movements
    # Reports the robot's position
    class Report < Movement
      def execute
        ensure_placed!
        "#{@robot.x},#{@robot.y},#{@robot.facing}"
      end
    end
  end
end 
# frozen_string_literal: true

module RobotSimulator
  module Movements
    # Places the robot at a specific position
    class Place < Movement
      def initialize(robot, x, y, facing)
        super(robot)
        @x = x
        @y = y
        @facing = facing
      end

      def execute
        validate_position!(@x, @y)
        validate_direction!(@facing)
        @robot.update_position(@x, @y, @facing)
      end
    end

    # Moves the robot forward
    class Forward < Movement
      def execute
        ensure_placed!
        new_x, new_y = calculate_new_position
        validate_position!(new_x, new_y)
        @robot.update_position(new_x, new_y, @robot.facing)
      end

      private

      def calculate_new_position
        case @robot.facing
        when 'NORTH' then [@robot.x, @robot.y + 1]
        when 'EAST'  then [@robot.x + 1, @robot.y]
        when 'SOUTH' then [@robot.x, @robot.y - 1]
        when 'WEST'  then [@robot.x - 1, @robot.y]
        end
      end
    end

    # Rotates the robot
    class Rotate < Movement
      def initialize(robot, direction)
        super(robot)
        @direction = direction # 1 for right, -1 for left
      end

      def execute
        ensure_placed!
        current_index = Core::Robot::DIRECTIONS.index(@robot.facing)
        new_facing = Core::Robot::DIRECTIONS[(current_index + @direction) % Core::Robot::DIRECTIONS.length]
        @robot.update_position(@robot.x, @robot.y, new_facing)
      end
    end
  end
end 
# frozen_string_literal: true

module RobotSimulator
  # Main controller for the robot simulator
  class Controller
    include Errors

    USAGE = <<~HELP
      Available commands:
        PLACE X,Y,DIRECTION - Place the robot at position X,Y facing DIRECTION (NORTH, EAST, SOUTH, WEST)
        MOVE               - Move the robot one unit in the current direction
        LEFT               - Rotate the robot 90 degrees to the left
        RIGHT              - Rotate the robot 90 degrees to the right
        REPORT            - Show the current position and direction of the robot
        HELP              - Show this help message
        EXIT              - Exit the program

      Example:
        PLACE 0,0,NORTH
        MOVE
        RIGHT
        REPORT
    HELP

    def initialize(io = IOInterface.new)
      @robot = Core::DotNewRobot.new
      @command_processor = CommandProcessor.new(@robot)
      @io = io
    end

    def run
      @io.display_welcome
      run_command_loop
    rescue Errors::IOError => e
      @io.display_error(e)
      exit(1)
    end

    private

    def run_command_loop
      loop do
        begin
          input = @io.read_command
          execute_command(input)
        rescue Errors::RobotError => e
          @io.display_error(e)
        rescue StandardError => e
          @io.display_error(Errors::RobotError.new("Unexpected error: #{e.message}"))
          exit(1)
        end
      end
    rescue Errors::IOError => e
      @io.display_goodbye
    end

    def execute_command(input)
      command = @command_processor.process(input)

      case command
      when :help
        @io.display_info(USAGE)
      when :exit
        @io.display_goodbye
        exit(0)
      else
        result = command.execute
        @io.display_success("Output: #{result}") if result
      end
    end
  end
end 
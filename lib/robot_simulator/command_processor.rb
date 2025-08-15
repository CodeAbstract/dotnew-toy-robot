# frozen_string_literal: true

module RobotSimulator
  # Processes and validates robot commands
  class CommandProcessor
    VALID_COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT EXIT HELP].freeze

    def initialize(robot)
      @robot = robot
    end

    def process(input)
      command, args = parse_input(input)
      validate_command!(command)
      
      case command
      when 'PLACE'
        create_place_command(args)
      when 'MOVE'
        Commands::MoveCommand.new(@robot)
      when 'LEFT'
        Commands::LeftCommand.new(@robot)
      when 'RIGHT'
        Commands::RightCommand.new(@robot)
      when 'REPORT'
        Commands::ReportCommand.new(@robot)
      when 'HELP'
        :help
      when 'EXIT'
        :exit
      end
    end

    private

    def parse_input(input)
      parts = input.to_s.strip.split(/\s+/, 2)
      command = parts[0]&.upcase
      args = parts[1]&.split(',')&.map(&:strip) || []
      
      [command, args]
    end

    def validate_command!(command)
      raise Errors::InvalidCommandError.new(command) unless VALID_COMMANDS.include?(command)
    end

    def create_place_command(args)
      raise Errors::InvalidPlaceCommandError.new unless args.length == 3

      x = Integer(args[0])
      y = Integer(args[1])
      direction = args[2].upcase

      Commands::PlaceCommand.new(@robot, x, y, direction)
    rescue ArgumentError
      raise Errors::InvalidPlaceCommandError.new
    end
  end
end 
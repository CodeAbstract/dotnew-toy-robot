# frozen_string_literal: true

module RobotSimulator
  # Handles all I/O operations for the robot simulator
  class IOInterface
    COLORS = {
      error: "\e[31m",   # Red
      success: "\e[32m", # Green
      warning: "\e[33m", # Yellow
      info: "\e[36m",    # Cyan
      reset: "\e[0m"     # Reset
    }.freeze

    def initialize(input: $stdin, output: $stdout)
      @input = input
      @output = output
    end

    def read_command
      print_prompt
      input = read_input
      raise Errors::IOError, 'End of input (Ctrl+D)' if input.nil?
      input.strip
    rescue Errno::EIO, IOError => e
      raise Errors::IOError, "Failed to read input: #{e.message}"
    end

    def display_welcome
      clear_screen
      print_message(<<~WELCOME, :info)
        =========================================== Robot Simulator ===========================================

        The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
        There are no other obstructions on the table surface.
        The robot is free to roam around the surface of the table but must be prevented from falling to destruction.
        Any movement that would result in the robot falling from the table must be prevented, however further valid \nmovement commands must still be allowed.

        Type 'HELP' for available commands
        Type 'EXIT' to quit
        =========================================================================================================
      WELCOME
    end

    def display_error(error)
      print_message(error.user_message, :error)
    end

    def display_success(message)
      print_message(message, :success)
    end

    def display_warning(message)
      print_message(message, :warning)
    end

    def display_info(message)
      print_message(message, :info)
    end

    def display_goodbye
      print_message("\nGoodbye!", :info)
    end

    private

    def read_input
      @input.gets&.chomp
    end

    def print_prompt
      @output.print "\nEnter command: "
    end

    def print_message(message, type = :info)
      color = COLORS[type]
      reset = COLORS[:reset]
      @output.puts "#{color}#{message}#{reset}"
    end

    def clear_screen
      return @output.puts("\n" * 100) if ENV['TEST']
      system('clear') || system('cls') || @output.puts("\n" * 100)
    end
  end
end 
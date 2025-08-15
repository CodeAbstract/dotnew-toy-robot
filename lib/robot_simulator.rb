# frozen_string_literal: true

# Main namespace for the robot simulator
module RobotSimulator
end

# Configuration
require_relative 'robot_simulator/config'

# Core components
require_relative 'robot_simulator/core/grid'
require_relative 'robot_simulator/core/robot'

# Error definitions
require_relative 'robot_simulator/errors/robot_errors'

# Movement strategies
require_relative 'robot_simulator/movements/movement'
require_relative 'robot_simulator/movements/position_movements'
require_relative 'robot_simulator/movements/reporting_movements'

# Command implementations
require_relative 'robot_simulator/commands/base_command'
require_relative 'robot_simulator/commands/movement_commands'
require_relative 'robot_simulator/commands/state_commands'

# IO and Controller
require_relative 'robot_simulator/io_interface'
require_relative 'robot_simulator/command_processor'
require_relative 'robot_simulator/controller' 
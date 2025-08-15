# Robot Challenge - DotNew

## Description

- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table but must be prevented from falling to destruction.
- Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

This is an application that can read in commands of the following form:

```plain
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the toy robot on the table in position X, Y and facing NORTH, SOUTH, EAST, or WEST. The origin (0,0) can be considered to be the SOUTHWEST corner. The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X, Y and orientation of the robot. A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.

## Constraints:

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot. Any move that would cause the robot to fall must be ignored.

Example Input and Output:

```plain
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

```plain
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

```plain
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```

## How to Run the Application

### Prerequisites

- Ruby 3.3.0 or higher
- Bundler gem

### Installation

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Make the script executable:
   ```bash
   chmod +x bin/robot
   ```

### Running the Application

The application can be run in several ways:

1. Using the executable script:
   ```bash
   ./bin/robot
   ```
   or simply:
   ```bash
   ./robot
   ```

2. Command-line options:
   ```bash
   # Show help message
   ./robot --help
   ```

### Configuration

The robot simulator can be configured using command-line arguments:

```bash
# Set grid size (1-10, default: 5)
./robot --grid-size 7
```

Configuration options:
- Grid size: Size of the square grid (NxN)
  - Default: 5
  - Minimum: 1
  - Maximum: 10

### Available Commands

Once the application is running, you can enter the following commands:

- `PLACE X,Y,DIRECTION` - Place the robot at position X,Y facing DIRECTION (NORTH, EAST, SOUTH, WEST)
- `MOVE` - Move the robot one unit in the current direction
- `LEFT` - Rotate the robot 90 degrees to the left
- `RIGHT` - Rotate the robot 90 degrees to the right
- `REPORT` - Show the current position and direction of the robot
- `HELP` - Show help message with available commands
- `EXIT` - Exit the application

Example session:
```
PLACE 0,0,NORTH
MOVE
RIGHT
REPORT
Output: 0,1,EAST
```

To exit the application:
- Type `EXIT` and press Enter
- Press Ctrl+C
- Press Ctrl+D (EOF)

### Running Tests

Run the test suite:
```bash
bundle exec rspec
```

For more detailed test output:
```bash
bundle exec rspec --format documentation
```

## Project Structure

```
.
├── bin/
│   └── robot           # Executable script
├── lib/
│   └── robot_simulator/
│       ├── commands/   # Command pattern implementations
│       ├── core/       # Core robot and grid functionality
│       ├── errors/     # Error definitions
│       └── movements/  # Movement strategy implementations
├── spec/              # Test files
├── Gemfile           # Ruby dependencies
├── README.md         # This file
└── robot            # Symlink to executable
```

## Development

The project follows these design patterns and principles:
- Command Pattern for robot commands
- Strategy Pattern for movement behaviors
- SOLID principles
- Comprehensive test coverage
- Error handling with custom error types

### Advanced Configuration

While the default implementation uses a 5x5 grid, the grid size can be configured for development and testing purposes using the command-line argument:

```bash
# Set grid size (1-10, default: 5)
./robot --grid-size 7
```

Note: The standard implementation assumes a 5x5 grid as per the original requirements. The configuration option is provided for development flexibility and testing purposes.
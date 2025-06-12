# Tic-Tac-Toe Verilog Implementation

## Project Overview
This project implements a complete Tic-Tac-Toe game in Verilog hardware description language. The implementation includes three main components:
1. A cell module (`TCell.v`) that manages individual game cells
2. A game controller module (`TBox.v`) that manages the overall game state
3. A comprehensive testbench (`TBox_tb.v`) for verification

## Module Descriptions

### TCell.v (Cell Module)
The basic building block of the game:
- **Inputs**: 
  - `clk`: Clock signal
  - `set`: Signal to set the cell value
  - `reset`: Signal to clear the cell
  - `set_symbol`: Value to set (X=1, O=0)
- **Outputs**:
  - `valid`: Indicates if cell is occupied
  - `symbol`: Stores X (1) or O (0)
- **Functionality**:
  - Initializes to empty state
  - Clears on reset
  - Sets symbol when not already occupied

### TBox.v (Game Controller)
The main game logic:
- **Inputs**:
  - `clk`: Clock signal
  - `set`: Signal to make a move
  - `reset`: Signal to reset game
  - `row`, `col`: 2-bit coordinates (01=row1, 10=row2, 11=row3)
- **Outputs**:
  - `valid`: Array of cell occupancy states
  - `symbol`: Array of cell values
  - `game_state`: Current game status
- **Features**:
  - Manages 3×3 grid of TCell instances
  - Tracks current player (X starts first)
  - Detects win conditions (rows, columns, diagonals)
  - Detects draw conditions (full board)
  - Prevents overwriting occupied cells
  - Handles game reset

### TBox_tb.v (Testbench)
Verification module:
- **Tests**:
  - Initial empty board state
  - O win scenario (diagonal)
  - X win scenario (row)
- **Features**:
  - Visual board display (X, O, _ for empty)
  - Automatic game state reporting
  - Test case macros for easy verification
  - Pass/fail reporting for each test case

## Game State Encoding
The game uses the following 2-bit state encoding:
- `00`: Game in progress
- `01`: X wins
- `10`: O wins
- `11`: Draw

## Coordinate System
- Rows and columns use 2-bit encoding:
  - `01`: First row/column
  - `10`: Second row/column
  - `11`: Third row/column

## How to Run the Simulation
1. Compile all Verilog files with a Verilog simulator (e.g., Icarus Verilog):
   ```bash
   iverilog -o tictactoe TBox_tb.v TBox.v TCell.v

    Run the simulation:
    bash

    vvp tictactoe

    Expected output shows:

        Board state after each move

        Game status messages

        Test case pass/fail results

Test Cases

The testbench verifies:

    Initial state:

        All cells empty

        Game state "Game on"

    O win scenario:

        Diagonal win (top-left to bottom-right)

        Proper state transition to "O won"

    X win scenario:

        First row win

        Proper state transition to "X won"

Implementation Notes

    Players alternate turns automatically (X always starts first)

    The game prevents moves on occupied cells

    Win detection checks all 8 possible winning combinations

    Reset functionality clears all cells and resets the game state

    The testbench provides clear visual output of the game board

Dependencies

    Verilog simulator (e.g., Icarus Verilog, ModelSim)

    Standard Verilog libraries

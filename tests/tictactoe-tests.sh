#!/bin/bash

set -e

. tests/utils/assert.sh

assert_contains "src/tictactoe.sh exit" "
+---+---+---+
|   |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
"
assert_end "Prints an empty board"

assert_contains "src/tictactoe.sh 0,0 exit" "
+---+---+---+
| X |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
"
assert_end "Accepts user input"

assert_contains "src/tictactoe.sh 0,0 0,1 0,2 1,0 exit" "
+---+---+---+
| X | O | X |
+---+---+---+
| O |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
"
assert_end "Alternates between two user inputs"

assert_contains "src/tictactoe.sh 0,0 1,0 0,1 1,1 0,2" "X won, yay!"
assert_contains "src/tictactoe.sh 1,0 0,0 1,1 0,1 1,2" "X won, yay!"
assert_contains "src/tictactoe.sh 2,0 0,0 2,1 0,1 2,2" "X won, yay!"
assert_contains "src/tictactoe.sh 1,0 0,0 1,1 0,1 2,0 0,2" "O won, yay!"
assert_end "Considers a full row as a winning move"

assert_contains "src/tictactoe.sh 0,0 0,1 1,0 1,1 2,0" "X won, yay!"
assert_contains "src/tictactoe.sh 0,1 0,0 1,1 1,0 2,1" "X won, yay!"
assert_contains "src/tictactoe.sh 0,2 0,0 1,2 1,0 2,2" "X won, yay!"
assert_end "Considers a full column as a winning move"

assert_contains "src/tictactoe.sh 0,0 0,1 1,1 0,2 2,2" "X won, yay!"
assert_contains "src/tictactoe.sh 0,2 0,0 1,1 0,1 2,0" "X won, yay!"
assert_end "Considers a full diagonal as a winning move"

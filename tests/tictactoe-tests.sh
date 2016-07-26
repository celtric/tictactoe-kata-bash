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

assert_contains "src/tictactoe.sh 00 exit" "
+---+---+---+
| X |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
"
assert_end "Accepts user input"

assert_contains "src/tictactoe.sh 00 01 02 10 exit" "
+---+---+---+
| X | O | X |
+---+---+---+
| O |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
"
assert_end "Alternates between two user inputs"

assert_contains "src/tictactoe.sh 00 10 01 11 02" "X won, yay!"
assert_end "Considers a full row as a winning move"
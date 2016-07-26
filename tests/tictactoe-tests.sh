#!/bin/bash

set -e

. tests/utils/assert.sh

assert_contains "src/tictactoe.sh" "
+---+---+---+
|   |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
|   |   |   |
+---+---+---+
"
assert_end prints_empty_board

#!/usr/bin/env bash

declare -a row0=(" " " " " ")
declare -a row1=(" " " " " ")
declare -a row2=(" " " " " ")

currentPlayer="X"

#---[ Helpers ]----------------------------------------------------------------#

RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

#---[ Functions ]--------------------------------------------------------------#

bye() {
    echo -e "\n${RED}Farewell, Professor Falken.$RESET"
    exit 0
}

printBoard() {
    echo -e "\033c"
    echo "+---+---+---+"
    echo "| ${row0[0]} | ${row0[1]} | ${row0[2]} |"
    echo "+---+---+---+"
    echo "| ${row1[0]} | ${row1[1]} | ${row1[2]} |"
    echo "+---+---+---+"
    echo "| ${row2[0]} | ${row2[1]} | ${row2[2]} |"
    echo "+---+---+---+"
    echo ""
}

handleCommand() {
    if [ $1 = "exit" ]; then
        bye
    fi
    x=${1:0:1}
    y=${1:1:2}
    selectCell $x $y
    checkWinnner
    printBoard
    switchPlayer
}

selectCell() {
    case $1 in
        0) row0[$2]=${currentPlayer};;
        1) row1[$2]=${currentPlayer};;
        2) row2[$2]=${currentPlayer};;
    esac
}

switchPlayer() {
    case "$currentPlayer" in
        "X") currentPlayer="O";;
        *) currentPlayer="X" ;;
    esac
}

checkWinnner() {
    if [ ${row0[0]} = "X" ] && [ ${row0[1]} = "X" ] && [ ${row0[2]} = "X" ]; then
        playerWon
    elif [ ${row1[0]} = "X" ] && [ ${row1[1]} = "X" ] && [ ${row1[2]} = "X" ]; then
        playerWon
    elif [ ${row2[0]} = "X" ] && [ ${row2[1]} = "X" ] && [ ${row2[2]} = "X" ]; then
        playerWon
    fi
}

playerWon() {
    echo -e "\n${GREEN}X won, yay!$RESET"
    exit 0
}

#---[ Main ]-------------------------------------------------------------------#

printBoard

for var in "$@"; do
    handleCommand "$var"
done

while true; do
    read -p "Player ${currentPlayer}, what's your move (xy)? " xy
    handleCommand $xy
done

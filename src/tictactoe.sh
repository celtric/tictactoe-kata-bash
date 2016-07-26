#!/usr/bin/env bash

declare -a board=(
    " " " " " "
    " " " " " "
    " " " " " "
)

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
    echo "| ${board[0]} | ${board[1]} | ${board[2]} |"
    echo "+---+---+---+"
    echo "| ${board[3]} | ${board[4]} | ${board[5]} |"
    echo "+---+---+---+"
    echo "| ${board[6]} | ${board[7]} | ${board[8]} |"
    echo "+---+---+---+"
    echo ""
}

handleCommand() {
    if [ $1 = "exit" ]; then
        bye
    fi
    row=${1:0:1}
    col=${1:2:3}
    selectCell $row $col
    printBoard
    checkWinnner
    switchPlayer
}

selectCell() {
    board[($1*3)+$2]=${currentPlayer}
}

switchPlayer() {
    case "$currentPlayer" in
        "X") currentPlayer="O";;
        *) currentPlayer="X" ;;
    esac
}

checkWinnner() {
    if [[ ${board[0]} = ${currentPlayer} ]] && [[ ${board[1]} = ${currentPlayer} ]] && [[ ${board[2]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[3]} = ${currentPlayer} ]] && [[ ${board[4]} = ${currentPlayer} ]] && [[ ${board[5]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[6]} = ${currentPlayer} ]] && [[ ${board[7]} = ${currentPlayer} ]] && [[ ${board[8]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[0]} = ${currentPlayer} ]] && [[ ${board[3]} = ${currentPlayer} ]] && [[ ${board[6]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[1]} = ${currentPlayer} ]] && [[ ${board[4]} = ${currentPlayer} ]] && [[ ${board[7]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[2]} = ${currentPlayer} ]] && [[ ${board[5]} = ${currentPlayer} ]] && [[ ${board[8]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[0]} = ${currentPlayer} ]] && [[ ${board[4]} = ${currentPlayer} ]] && [[ ${board[8]} = ${currentPlayer} ]]; then
        playerWon
    elif [[ ${board[2]} = ${currentPlayer} ]] && [[ ${board[4]} = ${currentPlayer} ]] && [[ ${board[6]} = ${currentPlayer} ]]; then
        playerWon
    fi
}

playerWon() {
    echo -e "\n${GREEN}$currentPlayer won, yay!$RESET"
    exit 0
}

#---[ Main ]-------------------------------------------------------------------#

printBoard

for var in "$@"; do
    handleCommand "$var"
done

while true; do
    read -p "Player ${currentPlayer}, what's your move (row,column)? " rc
    handleCommand $rc
done

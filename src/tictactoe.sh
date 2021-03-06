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

printBoard() {
    echo -e "\033c"
    for row in $(seq 0 2); do
        printBoardRowSeparator
        for col in $(seq 0 2); do
            printf "| ${board[$(((row*3)+col))]} "
        done
        echo "|"
    done
    printBoardRowSeparator
    echo ""
}

printBoardRowSeparator() {
    for col in $(seq 0 2); do
        printf "+---"
    done
    echo "+"
}

handleCommand() {
    if [ $1 = "exit" ]; then
        bye
    fi

    validSyntax='^[0-2]{1},[0-2]{1}$'
    if ! [[ $1 =~ $validSyntax ]]; then
        recoverableError "Invalid syntax. Example: to select the first cell, use 0,0"
        return
    fi

    row=${1:0:1}
    col=${1:2:3}
    boardKey=(row*3)+col

    if [[ ${board[boardKey]} != " " ]]; then
        recoverableError "Cell is already taken."
        return
    fi

    board[boardKey]=${currentPlayer}
    printBoard
    checkWinnner
    checkNoMoreMoves
    switchPlayer
}

switchPlayer() {
    case "$currentPlayer" in
        "X") currentPlayer="O";;
        *) currentPlayer="X" ;;
    esac
}

checkWinnner() {
    # Rows
    for i in $(seq 0 2); do
        checkWinnerBySpecificCells $i*3 $i*3+1 $i*3+2
    done

    # Columns
    for i in $(seq 0 2); do
        checkWinnerBySpecificCells $i $i+3 $i+6
    done

    # Diagonals
    checkWinnerBySpecificCells 0 4 8
    checkWinnerBySpecificCells 2 4 6
}

checkWinnerBySpecificCells() {
    for i in "$@"; do
        if [[ ${board[i]} != ${currentPlayer} ]]; then
            return
        fi
    done
    playerWon
}

checkNoMoreMoves() {
    for i in "${board[@]}"; do
        if [ "$i" = " " ]; then
            return
        fi
    done
    noOneWon
}

recoverableError() {
    printBoard
    echo -e "${RED}$1$RESET\n"
}

playerWon() {
    echo -e "${GREEN}$currentPlayer won, yay!$RESET\n"
    exit 0
}

noOneWon() {
    echo -e "${RED}A strange game. The only winning move is not to play. How about a nice game of chess?$RESET\n"
    exit 0
}

bye() {
    echo -e "\n${RED}Farewell, Professor Falken.$RESET"
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

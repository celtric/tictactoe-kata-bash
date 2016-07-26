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
    boardKey=(row*3)+col

    if [[ ${board[boardKey]} != " " ]]; then
        printBoard
        echo -e "${RED}Cell is already taken.$RESET\n"
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
    elif [[ ${board[2]} = ${currentPlayer} ]] && [[ ${board[4]} = ${currentPlayer} ]] && [[ ${board[6]} = ${currentPlayer} ]]; then
        playerWon
    fi
}

checkNoMoreMoves() {
    for i in "${board[@]}"; do
        if [ "$i" = " " ]; then
            return
        fi
    done
    noOneWon
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

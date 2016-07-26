#!/usr/bin/env bash

declare -a row0=(" " " " " ")
declare -a row1=(" " " " " ")
declare -a row2=(" " " " " ")

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
    case $x in
        0) row0[y]="X";;
        1) row1[y]="X";;
        2) row2[y]="X";;
    esac
    printBoard
}

#---[ Main ]-------------------------------------------------------------------#

printBoard

for var in "$@"; do
    handleCommand "$var"
done

while true; do
    read -p "Player A, what's your move (xy)? " xy
    handleCommand $xy
done

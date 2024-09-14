#!/bin/zsh

function findfast() {
    sudo find . -name "*$1*"
}

function findlogs() {
    sudo find / -type f -name "*.log"
}


#!/usr/bin/env bash
function pos
{
    local CURPOS
    read -sdR -p $'\E[6n' CURPOS
    CURPOS=${CURPOS#*[} # Strip decoration characters <ESC>[
    echo "${CURPOS}"    # Return position in "row;col" format
}
function row
{
    local COL
    local ROW
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo "${ROW#*[}"
}
function col
{
    local COL
    local ROW
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo "${COL}"
}
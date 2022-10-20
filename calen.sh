#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# calendar stuff - 6 month calendar, events, & food pantry
#
# even though cal turns off hilite for non-tty some code is still there
# have to filter out funky codes with 'cal.sed'
# otherwise awk oputput gets wonky
#
pre=9                                                    # pre event days
day=$(date +"%e")
mon=$(date +"%b")
grn="\033[2;32m"
non="\033[0m"

clear
title-80.sh -t line "Calendar & Events For The Next 30 Days & pre $pre"

cal -B 1 -A 4 | cal.sed | calen.awk -v d="$day" -v t=0   # cal mode
echo -ne "$grn"                                          # dim pre events
calendar -w -B "$pre" > ~/temp/temp                      # remove last event
head -n -1 ~/temp/temp | calen.awk -v t=1                # calendar mode
echo -ne "$non"
calendar -w -l 30 | calen.awk -v t=1                     # calendar mode
# pantry.sh | calen.awk -v t=2                           # other mode 2

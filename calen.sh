#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# calendar stuff - 6 month calendar, events, & food pantry
#
# even though 'cal' turns off hilite for non-tty some code is still there
# have to filter out funky codes with 'cal.sed'
# otherwise awk output gets wonky
#
# there is a glitch in 'calendar'
# -B includes the day after today as well
# so the date must be forced 2 days prior
#
# 2022-10-24
# updated for 'calendar' error
#
# 2022-11-01
# used head to limit julian display
#
ofs=2                                                    # error offset
pre=9                                                    # pre event days
day=$(date +"%e")
mon=$(date +"%b")
grn="\033[2;32m"
non="\033[0m"
unset LC_ALL

clear
title-80.sh -t line "Calendar & Events For The Next 30 Days & pre $pre"

cal -B 1 -A 4 | cal.sed | calen.awk -v d="$day" -v t=0   # cal mode

# ----------------------------------------------------------------------- before
bfr=$(date -d @$(($(date +"%s")-(ofs*24*60*60))) +"%F")  # before n days
bfr=${bfr//-/}                                           # remove '-'
echo -ne "$grn"                                          # dim pre events
calendar -t $bfr -w -B $((9-ofs)) | calen.awk -v t=1     # calendar mode
echo -ne "$non"
# ---------------------------------------------------------------- today & after
calendar -w -l 30 | calen.awk -v t=1                     # calendar mode
pantry.sh | calen.awk -v t=2                             # other mode 2
julian.sh -f future | head -n 13

#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# time zone data sorted by time
#
# 2023-12-10 added egrep
#-------------------------------------------------------------------------------
source ~/data/global.dat
out="$HOME/data/tz.dat"
#-------------------------------------------------------------------------------
if (($#>0))
then
   case $1 in
      -h) echo
         echo "tz.sh [-h egrep]"
         echo "no argument builds tz.dat"
         echo "-h help"
         echo "egrep argument"
         exit;;
      *)
         egrep "$1" "$out" --color
   esac
else
   clear
   fmt="%s %s %s %-5s %s\n"
   dte='TZ="UTC" 2000-01-02 00:00:00'
   tim="%F %T %z %Z"
   printf "Time Zones Sorted By Time -> %s\n" "$out"
   printf "%s\n" "$dte"
   printf "$fmt\n" $(date -d "$dte" +"$tim") "$TZ"
   sleep 1
   timedatectl list-timezones |
   while read tz
   do
      TZ=$tz
      printf "$fmt" $(date -d "$dte" +"$tim") "$tz"
   done | sort | tee "$out"
fi
#-------------------------------------------------------------------------------

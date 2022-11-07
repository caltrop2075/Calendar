#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# various julian dates
# keep track of julian epochs, birthdays, WTSHTF, TEOTWAWKI, or whatever
#
# data file
# yyy-mm-dd,optional offest,julian system / event
# offset overrides date, if date it is informational only
# blank lines print, comment lines skipped
#
# can calc astro date using offset but not input (-)date
#
# (-) offsets were causing issue, need tz adjust 5h/18000s
#
# modified to read from data file, no more long case/esac
# much easier to add & remove data from a file
#
# added separate categories combined into one file
# only rebuilds when a file is modified
# julian-future.dat  julian-happy.dat  julian-shit.dat  julian-systems.dat
#     -> julian.dat
#
# emoji output in the terminal is squirrely
# like reading a data file that has '\r' in it
#
#--------------------------------------------------------------------- variables
unset LC_ALL                                    # so float comma will work
w0=0                                            # extra numeric spaces
w1=$((41-3*w0))                                 # first column
w2=$((17+w0))
w3=$((9+w0))
w4=$((12+w0))
y="365.242198781"                               # day in year from HP48SX/GX/G
tz=$((${TZ#GMT}))                               # get tz str -> #
msg=$(printf "%5s: %s\n" "now" "$(date +"%F %T %a")")
fil="$HOME/data/julian.dat"
o=0
Wht="\033[0;37m"
non="\033[0m"
#-------------------------------------------------------- build sorted base file
find ~/data -name "julian-*.dat" |              # find data files
{
   flg=0
   while read lin                               # scan data files
   do
      if [ ~/data/julian.dat -ot $lin ]         # set rebuild flag
      then
         ((flg++))
      fi
   done
   if (( $flg ))                                # rebuild ?
   then
      # output to STDERR so other prgms can handle STDOUT properly
      echo -en "$Wht$flg file(s) changed, rebuilding ~/data/julian.dat$non\r" >&2 # > /dev/stderr
      cat ~/data/julian-* |
      while read lin
      do
         if [[ -n $lin && ${lin:0:1} != "#" ]]  # skip comments & blank lines
         then
            echo "$lin"
         fi
      done | sort > "$fil"
      sleep 3
   fi
}
#------------------------------------------------------------------ command line
if [[ -n $1 ]]
then
   case $1 in
      -h | --help )
         echo "usage: julian.sh [date string,-f file category,-o,-h,--help]"
         echo "   date string       yyyy-mm-dd"
         echo "                     base date for all dates"
         echo "   file category     -f category"
         echo "                     list a separate category file"
         echo "                     ~/data/julian-category.dat"
         echo "   list categories   -f"
         echo "                     cat1   cat2   cat3"
         echo "   show offsets      -o"
         echo "                     show the 1970-01-01 offsets"
         echo "   help              -h,--help"
         exit
         ;;
      -f )
         if [[ -n $2 ]]
         then
            fil="$HOME/data/julian-$2.dat"
            msg=$msg"\n$2"
         else
            echo "ERROR: need file category"
            find ~/data -type f -name "julian-*" -printf "%f\n" | sort |
            {
               m=4                              # cols
               c=0                              # counter
               while read lin
               do
                  ((c++))
                  lin=${lin#*-}
                  lin=${lin%.*}
                  printf "%-10s" "$lin"
                  if (( $((c%m)) == 0 ))
                  then
                     printf "\n"
                  fi
               done
               if (( $((c%m)) != 0 ))
               then
                  printf "\n"
               fi
            }
            exit
         fi
         ;;
      -o )
         clear
         o=1
         ;;
      * )
         if (( ${#1} < 10 ))                    # date string ?
         then
            echo "unknown command"
            exit 1
         else
            d=$(date +"%F %T %a" -d "$1")       # check valid date
            e=$?
            if (( $e ))
            then
               exit 1
            fi
            msg=$(printf "%5s: %s\n" "given" "$d")
         fi
   esac
else
   clear
fi
#----------------------------------------------------------------------- program
title-80.sh -t line "various julian dates\n$msg"
if [[ $1 == "" ]]
then
   sleep 1
fi
if (( $o ))
then
   printf "\033[0;37m%-"$w1"s%"$w2"s%"$w3"s%"$w4"s%17s\n\033[0m" "SYSTEM" "DAYS" "YEARS" "BASE DATE" "OFFSET"
else
   printf "\033[0;37m%-"$w1"s%"$w2"s%"$w3"s%"$w4"s\n\033[0m" "SYSTEM" "DAYS" "YEARS" "BASE DATE"
fi

while IFS="|" read dte ofs msg emo           # read data
do
   if [[ -z $dte ]] && [[ -z $ofs ]]         # print blank lines
   then
      echo
   elif [[ ${dte:0:1} != "#" ]]              # skip comments
   then
      if [[ -z $ofs ]]
      then                                   # if no ofs use dte
         ofs=$(date -d "$dte" +"%s")
         ofs=$(((ofs/60/60-tz)/24))        # tz adjust
      else                                   # if ofs calc date
         tmp=$(echo "scale=20;($ofs*24+$tz)*60*60" | bc)
         tmp=${tmp%.*}                       # remove trailing decimal
         dte=$(date -d "@$tmp" +"%F")
      fi

      if [[ -z $1 ]]                         # if cmd lin input
      then
         sec=$(date +"%s")                   # curr date
      else
         sec=$(date +"%s" -d "$1")           # input date
      fi
                                             # calc & display
      jul=$(echo "scale=20; ($sec/60/60-$tz)/24-($ofs)" | bc) # -$ofs --nnn -> -(-nnn)
      yr=$(echo "scale=20; $jul/$y" | bc)
      if [ -z "$emo" ]
      then                                   # no emoji
         msg=${msg:0:$((w1-1))}              # truncate message
         for ((j=${#msg};j<$w1;j++))         # easy eye dot
         do
            msg=$msg"‧"
         done
         if (( $o ))
         then
            printf "%-"$w1"s%"$w2".6f%"$w3".2f%"$w4"s%'17.5f\n" "$msg" "$jul" "$yr" "$dte" "$ofs"
         else
            printf "%-"$w1"s%"$w2".6f%"$w3".2f%"$w4"s\n" "$msg" "$jul" "$yr" "$dte"
         fi
      else                                   # emoji
         msg=${msg:0:$((w1-3))}              # truncate message
         case $emo in                        # emoji needing extra spc
            ☀️|☠️|☢️|☣️|☣️|⚠️|❄️|🍽️ )       # add extra emoji space
               emo=$emo" " ;;
         esac
         emo=$emo" "                         # emoji space
         for ((j=${#msg};j<$((w1-2));j++))   # easy eye dot
         do
            msg=$msg"‧"
         done
         if (( $o ))
         then
            printf "%s%-"$w1"s%'"$w2".6f%'"$w3".2f%'"$w4"s%'17.5f\n" "$emo" "$msg" "$jul" "$yr" "$dte" "$ofs"
         else
            printf "%s%-"$w1"s%'"$w2".6f%'"$w3".2f%'"$w4"s\n" "$emo" "$msg" "$jul" "$yr" "$dte"
         fi
      fi
   fi
done < "$fil"
#-------------------------------------------------------------------------------

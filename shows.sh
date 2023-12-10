#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# shows.dat display with optional calendar
# ~/temp/temp.txt shows
# ~/temp/temp.dat calendar
#
# 2023-05-09
# worked on last month display
# tweaked read
#
clear

msg="shows: auction, fleamarket, tractor
ALL shows are in decline, as is the entire world
these are the End Times of Bible: Revelation"

if [[ $1 = "-h" || $1 = "--help" ]]                   # help
then
   echo "usage: shows.sh"
   echo "       shows.sh -n   no calendar"
else
   echo -n > ~/temp/temp.dat                          # initialization
   echo -n > ~/temp/temp.txt
   lst=0

   title-80.sh -t line "$msg" | tee ~/Documents/Shows/_Shows.txt

cat ~/data/shows.dat |
   while read dt1 dt2 str
   do
      q=${dt1:0:1}
      if [[ $q != "" ]] && [[ $q != "#" ]]            # ignore blank & comment
      then
         dw1=$(date -d $dt1 +"%a")                    # get dw1
         jd1=$(date -d $dt1 +"%s")
         dm1=$(date -d $dt1 +"%m")

         dw2=$(date -d $dt2 +"%a")                    # get dw2
         jd2=$(date -d $dt2 +"%s")
         dm2=$(date -d $dt2 +"%m")

         jd0=$(( ($jd2-$jd1)/60/60/24+1 ))

         printf "%s\n%s %s   %s %s   %s day\n\n" "$str" "$dt1" "$dw1" "$dt2" "$dw2" "$jd0" >> ~/temp/temp.txt
         if [[ $1 != "-n" && $dm1 != $lst ]]
         then
            cal -d $dt1 | shows.sed >> ~/temp/temp.dat   # need sed rm hilite strip
            lst=$dm1                                  # save last printed month
         fi
         if [[ $1 != "-n" && $dm1 != $dm2 ]]          # print overlap/last month
         then
            cal -d $dt2 | shows.sed >> ~/temp/temp.dat   # need sed rm hilite strip
            lst=$dm2                                  # save last printed month
         fi
      fi
   done
   cat ~/temp/temp.dat | shows.awk -v f=~/temp/temp.txt | tee -a ~/Documents/Shows/_Shows.txt
fi

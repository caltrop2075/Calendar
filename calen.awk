#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# hilite calen stuff
# ==============================================================================
BEGIN {
   Wht="\033[0;37m"
   rev="\033[0;30;42m"                       # normal
   # rev="\033[0;7m"                           # brighter
   non="\033[0m"
}
# ==============================================================================
{
   switch($0)
   {
         case /[A-Za-z]+ [0-9]{4}/ :            # >>> hilite select records
         case /PICKUP/ :
            dte=$1" "$2
            printf(Wht"%s\n"non,$0)
            break
         default :
            switch(t)                           # >>> non-select record handling
            {
               case 0 :                         # >>> cal mode
                  if(NR>2 && NR<9)
                  {
                     a=substr($0,1,22)          # pull apart month cols
                     b=substr($0,23,22)
                     c=substr($0,45)
                     if(match(b,d))             # search second month col for day
                        sub(d,rev d non,b)      # hilite day
                     printf("%s%s%s\n",a,b,c)   # combine month cols
                  }
                  else
                     print
                  break
               case 1 :                         # >>> calendar mode
                  sub(/.\t/," ")             # remove * & \t
                  print
                  break
               case 2 :                         # >>> other
                  print
            }
   }
}
# ==============================================================================
END {
}
# ==============================================================================
# functions
# ------------------------------------------------------------------------------
# ==============================================================================

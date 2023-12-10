#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# reformat calendar
#
# optional boarder b=1
# ==============================================================================
BEGIN {
   s=""                          # build string
   f=1                           # print flag

   p=""                          # pad for single day
   for(i=0;i<18;i++)
      p=p" "

   d=sprintf("+")                # top & bot border
   for(i=0;i<22;i++)
      d=sprintf("%s-",d)
   d=sprintf("%s+",d)

   if(b)
      printf("%s\n",d)
 }
# ==============================================================================
{
   sub(/ +$/,"")                 # remove trailing spc
   lr()                          # split line
   switch(NR)
   {
      case 1 :
         s=$0
         pr()
         break
      case 2 :
         s=r" "l
         pr()
         break
      case 3 :
         if(l!="  ")
         {
            s=p l
            pr()
            f=0                  # don't print last line
         }
         s=r
         break
      default :
         s=s" "l
         pr()
         s=r
   }

}
# ==============================================================================
END {
   if(f)
      pr()
   if(b)
      printf("%s\n",d)
}
# ==============================================================================
# functions
# ------------------------------------------------------------------------------
function lr()
{
   l=substr($0,1,2)
   r=substr($0,4)
}
# ------------------------------------------------------------------------------
function pr()
{
   if(b)
      printf("| %-20s |\n",s)
   else
      printf("%-20s\n",s)
}
# ==============================================================================
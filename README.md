# Calendar
calendar utilities


Calendar Utilities

cal.sh      9 month calendar with current month in middle
cal.sed     strips control chars from cal

calen.sh    cal & calendar usage
            6 month calendar with hilited events
            need '~/.calendar/calendar' file
            up to you to figure out that mess
calen.awk   display output

- - - - -

THERE IS A GLITCH IN 'calendar'
-B includes the day after today as well
so the date must be forced 2 days prior

there is NO contact information other than it was an old BSD program
it is a core utility and therefore not supposed to have errors
WTF! am I supposed to find the source & fix it?
last time I tried contact listen in man page...
I was told they no longer do the program
it is FUCKED!!! but can be worked around

- - - - -

FYI: 'sort' IS BORKED AS WELL

another core utility with a glitch
but no one seems to care

I have to 'export LC_ALL=C' in '.profile' to get things to sort right
but that also makes some other programs not work right
BASH & file manager were also NOT right

i fix the 'sort' command used with find by printing a '|' between fields
then sorting with a key
$ find ~ -type f -iname "whatever" -printf "%h|%f\n" | sort -t "|" -k 1
that way only the directories are sorted then the file names

yeah, some things in Linux are messed up and no one to contact

- - - - -

my system:
           OS   Linux Mint 20.1 ulyssa
       Kernel   GNU/Linux 5.4.0-128-generic x86_64
   Kernel ver   #144-Ubuntu SMP Tue Sep 20 11:00:04 UTC 2022
      Desktop   MATE Desktop Environment 1.24.0
         Bash   5.0.17(1)-release x86_64-pc-linux-gnu
    Mono Font   DejaVuSansMono.ttf: "DejaVu Sans Mono" "Book"

- - - - -

I wonder... are these glitches deliberate...?
I would not put it past BIG Companies to do something like this
   or a GOVERNMENT...
THEY do not like Free and Open Source Software (FOSS)

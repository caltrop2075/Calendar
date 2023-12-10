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
dow.sh      yyyy dd dow n -> date
food.sh     food bank days using julian-food.dat
food2.sh    food bank days calculated starting with current month
julian.sh   various julian dates from julian-*.dat -> julian.dat
            fields separated with '|'
               1 DATE
               2 OFFSET which overrides DATE
               3 DESCRIPTION
               4 EMOJI if your system supports it
            have as many julian-*.dat you want
            ~/data/julian-future.dat
            ~/data/julian-happy.dat
            ~/data/julian-shit.dat
            ~/data/julian-systems.dat     sample file
            ~/data/julian.dat             built from separate files
mcal.sh     3 calendars starting on Monday
mcal.awk    reformats cals, can be used stand alone
shows.sh    list of shows with calendar, -n no calendar
shows.sed   strips control codes from calendar
shows.awk   formats the output
tz.sh       genrates a time zone list sorted by time
            with an argument egreps that sorted list, tz.sh  "US/"

- - - - -

two different calendar formats

1,24                    25,21                46
0        1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
      July 2023              August 2023            September 2023
 Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
                 1  2        1  2  3  4  5  6                 1  2  3
  3  4  5  6  7  8  9     7  8  9 10 11 12 13     4  5  6  7  8  9 10
 10 11 12 13 14 15 16    14 15 16 17 18 19 20    11 12 13 14 15 16 17
 17 18 19 20 21 22 23    21 22 23 24 25 26 27    18 19 20 21 22 23 24
 24 25 26 27 28 29 30    28 29 30 31             25 26 27 28 29 30
 31

1,29                         30,21                51
0        1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
 +----------------------+   +----------------------+   +----------------------+
 |      July 2023       |   |     August 2023      |   |    September 2023    |
 | Mo Tu We Th Fr Sa Su |   | Mo Tu We Th Fr Sa Su |   | Mo Tu We Th Fr Sa Su |
 |                 1  2 |   |     1  2  3  4  5  6 |   |              1  2  3 |
 |  3  4  5  6  7  8  9 |   |  7  8  9 10 11 12 13 |   |  4  5  6  7  8  9 10 |
 | 10 11 12 13 14 15 16 |   | 14 15 16 17 18 19 20 |   | 11 12 13 14 15 16 17 |
 | 17 18 19 20 21 22 23 |   | 21 22 23 24 25 26 27 |   | 18 19 20 21 22 23 24 |
 | 24 25 26 27 28 29 30 |   | 28 29 30 31          |   | 25 26 27 28 29 30    |
 | 31                   |   |                      |   |                      |
 +----------------------+   +----------------------+   +----------------------+

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

WARNING!!!
have a data directory in home for *.dat files
$HOME/data

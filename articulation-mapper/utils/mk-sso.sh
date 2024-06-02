#!/bin/bash
#

SOURCE="sso-keyswitches.csv"
mk-file() {
    COLUMN=$1
    TARGET=$2
    cut -f1,$COLUMN -d, $SOURCE | tail +2 | sed 's/$//;/,$/d;s/,/ /' > $TARGET
}

mk-file 2 sso-Violins-1.txt
mk-file 3 sso-Violins-2.txt
mk-file 4 sso-Violas.txt
mk-file 5 sso-Cellos.txt
mk-file 6 sso-Basses.txt
mk-file 7 sso-Horn-Solo.txt
mk-file 8 sso-Horn-a2.txt
mk-file 9 sso-Horns-a6.txt
mk-file 10 sso-Trumpet-Solo.txt
mk-file 11 sso-Trumpet-a2.txt
mk-file 12 sso-Trumpet-a6.txt
mk-file 13 sso-Trombone-Solo.txt
mk-file 14 sso-Trombone-a2.txt
mk-file 15 sso-Bass-Trombone-solo.txt
mk-file 16 sso-Bass-Trombone-a2.txt
mk-file 17 sso-Contrabass-Trombone.txt
mk-file 18 sso-Tuba.txt
mk-file 19 sso-Contrabass-Tuba.txt
mk-file 20 sso-Cimbassi.txt
mk-file 21 sso-AltoFlute.txt
mk-file 22 sso-Bass-Clarinet.txt
mk-file 23 sso-Bass-Flute.txt
mk-file 24 sso-Bassoon-Solo.txt
mk-file 25 sso-Bassoons-a2.txt
mk-file 26 sso-Clarinet-Solo.txt
mk-file 27 sso-Clarinet-a2.txt
mk-file 28 sso-Contrabass-Clarinet.txt
mk-file 29 sso-Contrabasson.txt
mk-file 30 sso-Cor-Anglais.txt
mk-file 31 sso-Flute-Solo.txt
mk-file 32 sso-Flute-a2.txt
mk-file 33 sso-Oboe-Solo.txt
mk-file 34 sso-Oboe-a2.txt
mk-file 35 sso-Piccolo.txt

cut -f2 -d" "  sso-*txt | sort -u | sed 's/\(.*\)/CUSTOM \1 \1/' > notation.ini
cp sso-*txt ../articulation-maps/

#!/usr/bin/bash

##################################
echo "Setup Variables..."
#
MCMAP="/root/mcmap/mcmap"
COLORS="/root/mcmap/colors.json"
OVERWORLD_SAVE="/root/world"
NETHER_SAVE="/root/world/DIM-1"
OUTPUT_FOLDER="/var/www/html/maps/oneoffs"
FROMX="-3000"
FROMZ="-3000"
TOX="1000"
TOZ="1000"
NFROMX="-300"
NFROMZ="-500"
NTOX="-100"
NTOZ="-200"
NETHER_MARKERS="-marker -204 -398 white"
$PLACENAME=fromrp1

##################################
echo "Render Overworld One-off map..."
#
#echo "Render northeast maps..."
#$MCMAP -splits 4 -colors $COLORS -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne.png
#echo "Render northwest maps..."
#$MCMAP -splits 4 -colors $COLORS -nw -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-nw.png
#echo "Render southwest maps..."
#$MCMAP -splits 4 -colors $COLORS -sw -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-sw.png
#echo "Render southeast maps..."
#$MCMAP -splits 4 -colors $COLORS -se -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-se.png

##################################
echo "Render Overworld Nowater Maps..."
#
#$MCMAP -splits 4 -colors $COLORS -nowater -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne-NOWATER.png

##################################
echo "Render CAVE Maps..."
#
#for y in $(seq -w 1 8 129)
#  do
#    echo "Rendering Cave maps at max Y $y"
#    $MCMAP -splits 4 -colors $COLORS -max $y -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/caves/overworld-facing-ne-caves-maxY$y.png
# done

##################################
echo "Render Nether Maps..."
echo "Placing markers $NETHER_MARKERS"
#
for y in $(seq -w 60 4 100)
  do
    echo "Rendering nether maps at max Y $y"
    $MCMAP -splits 4 -colors $COLORS -max $y -ne -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-$PLACENAME-facing-ne-maxY$y.png
    $MCMAP -splits 4 -colors $COLORS -max $y -nw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-$PLACENAME-facing-nw-maxY$y.png
    $MCMAP -splits 4 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-$PLACENAME-facing-sw-maxY$y.png
    $MCMAP -splits 4 -colors $COLORS -max $y -se -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-$PLACENAME-facing-se-maxY$y.png
 done

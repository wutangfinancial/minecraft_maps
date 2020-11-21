#!/usr/bin/bash

##################################
echo "Setup Variables..."
#
MCMAP="/root/mcmap/mcmap"
COLORS="/root/mcmap/colors.json"
OVERWORLD_SAVE="/root/world"
NETHER_SAVE="/root/world/DIM-1"
OUTPUT_FOLDER="/var/www/html/maps"
FROMX="-3000"
FROMZ="-3000"
TOX="1000"
TOZ="1000"
NFROMX="-1000"
NFROMZ="-1000"
NTOX="1000"
NTOZ="1000"
NETHER_MARKERS="-marker -589 -154 red -marker -90 -173 green -marker 0 0 blue -marker -2 29 white"

##################################
#echo "Clean up $OUTPUT_FOLDER..."
#
#echo "removing these files:"
find $OUTPUT_FOLDER -name "*.png" -ls
#find $OUTPUT_FOLDER -name "*.png" -exec rm {} \;
mkdir -p $OUTPUT_FOLDER/caves
mkdir -p $OUTPUT_FOLDER/nether
mkdir -p $OUTPUT_FOLDER/end

##################################
echo "Render Overworld maps..."
#
echo "Render northeast maps..."
$MCMAP -splits 4 -colors $COLORS -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne.png
echo "Render northwest maps..."
$MCMAP -splits 4 -colors $COLORS -nw -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-nw.png
echo "Render southwest maps..."
$MCMAP -splits 4 -colors $COLORS -sw -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-sw.png
echo "Render southeast maps..."
$MCMAP -splits 4 -colors $COLORS -se -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-se.png

##################################
echo "Render Overworld Nowater Maps..."
#
$MCMAP -splits 4 -colors $COLORS -nowater -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne-NOWATER.png

##################################
echo "Render CAVE Maps..."
#
for y in $(seq -w 1 8 129)
  do
    echo "Rendering Cave maps at max Y $y"
    $MCMAP -splits 4 -colors $COLORS -max $y -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/caves/overworld-facing-ne-caves-maxY$y.png
 done

##################################
echo "Render Nether Maps..."
echo "Placing markers $NETHER_MARKERS"
#
for y in $(seq -w 1 8 129)
  do
    echo "Rendering nether maps at max Y $y"
    $MCMAP -splits 4 -colors $COLORS -max $y -ne -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-ne-maxY$y.png
    echo $MCMAP -splits 4 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-sw-maxY$y.png
    $MCMAP -splits 4 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-sw-maxY$y.png
 done

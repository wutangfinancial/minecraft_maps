#!/usr/bin/bash

##################################
echo "Setup Variables..."
#
MCMAP="/root/mcmap.backup/mcmap"
COLORS="/root/mcmap.backup/colors.json"
OVERWORLD_SAVE="/root/world"
NETHER_SAVE="/root/world/DIM-1"
OUTPUT_FOLDER="/var/www/html/maps"
FROMX="-4000"
FROMZ="-4000"
TOX="1000"
TOZ="1000"
NFROMX="-1000"
NFROMZ="-1000"
NTOX="1000"
NTOZ="1000"
# markers: green=portals, red=hot_spots, blue=coords(every 500), white=origin
NETHER_MARKERS="-marker -589 -154 red -marker -90 -173 green -marker -2 29 green -marker -206 -399 green -marker -230 -333 green -marker 0 0 white -marker 500 500 blue -marker 1000 1000 blue -marker -500 -500 blue -marker -1000 -1000 blue -marker 0 500 blue -marker 0 1000 blue -marker 0 -500 blue -marker 0 -1000 blue -marker 500 0 blue -marker 1000 0 blue -marker -500 0 blue -marker -1000 0 blue -marker -500 500 blue -marker -1000 1000 blue -marker 500 -500 blue -marker 1000 -1000 blue -marker -206 -499 red -marker -206 -599 red -marker -206 -699 red -marker -206 -799 red"

##################################
#echo "Clean up $OUTPUT_FOLDER..."
#
#echo "removing these files:"
#find $OUTPUT_FOLDER -name "*.png" -ls
#find $OUTPUT_FOLDER -name "*.png" -exec rm {} \;
mkdir -p $OUTPUT_FOLDER/caves
mkdir -p $OUTPUT_FOLDER/nether
mkdir -p $OUTPUT_FOLDER/end

##################################
echo "Render Overworld maps..."
#
echo "Render northeast maps..."
echo $MCMAP -splits 16 -colors $COLORS -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne.png
$MCMAP -splits 16 -colors $COLORS -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne.png
echo "Render northwest maps..."
$MCMAP -splits 16 -colors $COLORS -nw -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-nw.png
echo "Render southwest maps..."
$MCMAP -splits 16 -colors $COLORS -sw -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-sw.png
echo "Render southeast maps..."
$MCMAP -splits 16 -colors $COLORS -se -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-se.png -shading

##################################
echo "Render Overworld Nowater Maps..."
#
$MCMAP -splits 16 -colors $COLORS -nowater -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/overworld-facing-ne-NOWATER.png

##################################
echo "Render CAVE Maps..."
#
for y in $(seq -w 1 8 129)
  do
    echo "Rendering Cave maps at max Y $y"
    $MCMAP -splits 16 -colors $COLORS -max $y -ne -from $FROMX $FROMZ -to $TOX $TOZ $OVERWORLD_SAVE -file $OUTPUT_FOLDER/caves/overworld-facing-ne-caves-maxY$y.png
 done

##################################
echo "Render Nether Maps..."
echo "Placing markers $NETHER_MARKERS"
#
for y in $(seq -f "%03g" 8 1 22)
  do
    echo "Rendering nether maps at max Y $y"
    $MCMAP -splits 16 -colors $COLORS -max $y -ne -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-ne-maxY$y.png
    echo $MCMAP -splits 16 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-sw-maxY$y.png
    $MCMAP -splits 16 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-sw-maxY$y.png -shading
 done
for y in $(seq -w 32 6 104)
  do
    echo "Rendering nether maps at max Y $y"
    $MCMAP -splits 16 -colors $COLORS -max $y -ne -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-ne-maxY$y.png
    echo $MCMAP -splits 16 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-sw-maxY$y.png
    $MCMAP -splits 16 -colors $COLORS -max $y -sw -from $NFROMX $NFROMZ -to $NTOX $NTOZ $NETHER_MARKERS $NETHER_SAVE -file $OUTPUT_FOLDER/nether/nether-facing-sw-maxY$y.png -shading
 done

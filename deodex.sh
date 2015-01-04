#!/bin/bash

echo "Every *.odex in odex folder will be deodex and the clesses.dex will be moved into the classes_dex folder"
echo -ne "Enter API level and press enter : "
read API

echo "Creating classes.dex"
for l in `ls odex/*.odex | sed "s/.odex//"`; do java -jar -Duser.language=en oat2dex.jar $l.odex $l.dex; done > /dev/null 2>&1
for l in `ls odex/*.odex | sed "s/.odex//"`; do java -jar baksmali.jar -a $API -x $l.dex -o $l; done
for l in `ls odex/*.odex | sed "s/.odex//"`; do a=`echo $l | sed "s/odex//"` && mkdir -p classes_dex/$a && java -jar smali.jar -a 21 $l -o classes_dex/$a/classes.dex; done
for l in `ls odex/*.odex | sed "s/.odex//"`; do rm -rf $l*; done
echo "Done"

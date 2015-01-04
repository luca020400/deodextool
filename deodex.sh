#!/bin/bash

echo "Every *.odex in odex folder will be deodex and the clesses.dex will be moved into the classes_dex folder"

for l in `ls odex/*.odex | sed "s/.odex//"`; do java -jar -Duser.language=en oat2dex.jar $l.odex $l.dex; done
for l in `ls odex/*.odex | sed "s/.odex//"`; do java -jar baksmali-2.0.3.jar -a 21 -x $l.dex -o $l; done
for l in `ls odex/*.odex | sed "s/.odex//"`; do a=`echo $l | sed "s/odex//"` && mkdir -p classes_dex/$a && java -jar smali-2.0.3.jar -a 21 $l -o classes_dex/$a/classes.dex; done

echo "Done"

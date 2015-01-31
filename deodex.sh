#!/bin/bash

dedeox () {
a=`echo $1 | sed "s/odex//"`
echo "Dedeoxing $1.apk"
java -jar -Duser.language=en oat2dex.jar $1.odex $1.dex > /dev/null 2>&1
java -jar baksmali.jar -a $API -x $l.dex -o $1
mkdir -p tmp/$a && java -jar smali.jar -a 21 $1 -o tmp/$a/classes.dex
echo "$1.apk classes.dex created"
echo
}

inject () {
b=`echo $1 | sed "s/odex//"`
echo "Injecting $1 classex.dex into $1.apk"
cp $1.apk deodexed/.
zip -r deodexed/$b tmp/$b/classes.dex
echo "classex.dex injected"
echo
}

cleanup () {
rm -rf tmp
}

echo "Every *.apk and *.odex in odexed folder will be deodex and the clesses.dex will be injected into the *.apk"
echo -ne "Enter API level and press enter : "
read API
for l in `ls odex/*.odex | sed "s/.odex//"`; do dedeox $l && inject $l; done > /dev/null 2>&1
cleanup
echo "Done"

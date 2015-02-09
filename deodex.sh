#!/bin/bash

ver="2.0"

dedeox () {
a=`echo $1 | sed "s/odexed\///"`
mkdir -p tmp/$a
if [ -f $1.apk ]; then
    echo "Dedeoxing $a.apk"
elif [ -f $1.jar ]; then
    echo "Dedeoxing $a.jar"
fi
java -jar -Duser.language=en oat2dex.jar $1.odex tmp/$a.dex > /dev/null 2>&1
java -jar baksmali.jar -a 21 -x tmp/$a.dex -o tmp/$a
java -jar smali.jar -a 21 tmp/$a -o tmp/$a/classes.dex
if [ -f $1.apk ]; then
    echo "$a.apk classes.dex created"
elif [ -f $1.jar ]; then
    echo "$a.jar classes.dex created"
fi
echo
}

inject_apk () {
a=`echo $1 | sed "s/odexed\///"`
if [ -f $1.apk ]; then
    echo "Injecting $a classex.dex into $a.apk"
    cp $1.apk deodexed/.
    zip -r deodexed/$a.apk tmp/$a/classes.dex
elif [ -f $1.jar ]; then
    echo "Injecting $a classex.dex into $a.jar"
    cp $1.jar deodexed/.
    zip -r deodexed/$a.jar tmp/$a/classes.dex
fi
echo "classex.dex injected"
echo
}

cleanup () {
rm -rf tmp
}

echo "Dedeox tool by @luca020400 ver $ver"
echo "It supports only LOLLIPOP"
echo "Every *.apk/*.jar and *.odex in odexed folder will be deodex and the clesses.dex will be injected into the *.apk/*.jar"
for l in `ls odexed/*.odex | sed "s/.odex//"`; do dedeox $l && inject $l; done
cleanup
echo "Done"

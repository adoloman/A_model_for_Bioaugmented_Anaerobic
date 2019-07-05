#!/bin/bash
# tested with JDK 1.8.0

# java 8 in Fedora is located at: /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.fc30.x86_64/bin/java
# the folder itself is available with a shortcut via /usr/lib/jvm/java-1.8.0
# the folder itself is available with a shortcut via /usr/lib/jvm/java-1.8.0-openjdk

# java 8 in Ubuntu is located at : /usr/lib/jvm/java-8-openjdk-amd64/bin/java
# the folder itself is available with a shortcut via /usr/lib/jvm/java-1.8.0-openjdk-amd64
JAVA_FOLDER=$(find '/usr/lib/jvm' -name "*java*8*openjdk*" -type d)
echo $JAVA_FOLDER

JAVA_8_EXEC=$JAVA_FOLDER'/bin/java'
echo $JAVA_8_EXEC
JAVAC_8_EXEC=$JAVA_FOLDER'/bin/javac'
echo $JAVAC_8_EXEC
# root folder of iDynoMICs
DYNO_PATH=$(dirname $(dirname $(realpath $0)))
SRC_PATH=$DYNO_PATH'/src'

echo 'Collecting all path needed to build / compile / run:'
CLASS_PATHs=$SRC_PATH:$DYNO_PATH'/bin'
echo $CLASS_PATHs

for jar_file in $JAVA_FOLDER'/jre/lib/'*.jar; do
	echo $jar_file
	CLASS_PATHs=$CLASS_PATHs:$jar_file
done

for jar_file in $JAVA_FOLDER'/jre/lib/ext/'*.jar; do
	echo $jar_file
	CLASS_PATHs=$CLASS_PATHs:$jar_file
done

for jar_file in $DYNO_PATH'/src/lib/'*.jar; do
	echo $jar_file
	CLASS_PATHs=$CLASS_PATHs:$jar_file
done

echo 'Purging previous build...'
BIN_OUT=$DYNO_PATH'/bin'
rm -rf $BIN_OUT
mkdir $BIN_OUT

#  Compiling
cd $SRC_PATH
echo 'Compiling ...'
#$JAVAC_8_EXEC -encoding utf8 -classpath $CLASS_PATHs -d $BIN_OUT -sourcepath $SRC_PATH $SRC_PATH'/iDynoOptimizer/Driver.java'
$JAVAC_8_EXEC -encoding utf8 -classpath $CLASS_PATHs -d $BIN_OUT -sourcepath $SRC_PATH $SRC_PATH'/idyno/Idynomics.java'

# launch command
cd $DYNO_PATH'/bin'
echo 'Launching ...'
#echo "$JAVA_8_EXEC -Dfile.encoding=UTF-8 -classpath $CLASS_PATHs idyno.Idynomics"
#$JAVA_8_EXEC -Dfile.encoding=UTF-8 -classpath $CLASS_PATHs idyno.Idynomics

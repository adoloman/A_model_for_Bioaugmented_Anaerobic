#!/bin/bash
# tested with JDK 1.8.0
export LANG=C.UTF-8
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

BIN_OUT=$DYNO_PATH'/bin'

echo 'Collecting all path needed to build / compile / run:'
CLASS_PATHs=$BIN_OUT
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/charsets.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/cldrdata.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/dnsns.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/icedtea-sound.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/jaccess.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/java-atk-wrapper.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/localedata.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/nashorn.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/sunec.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/sunjce_provider.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/sunpkcs11.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/ext/zipfs.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/jce.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/jsse.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/management-agent.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/resources.jar'
CLASS_PATHs=$CLASS_PATHs:$JAVA_FOLDER'/jre/lib/rt.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/ApacheCommonsIO2.4.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/colt.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/commons-cli-1.2.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/commoms-codec-1.8.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/commoms-lang3-31.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/commoms-math3-3.4.1.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/Jama-1.0.2.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/jcommon-1.0.12.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/jcommon-1.0.20.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/jdom.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/jfreechart-1.0.15.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/jfreechart-1.0.9.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/JMetal-4.3.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/rsytaxtextarea.jar'
CLASS_PATHs=$CLASS_PATHs:$SRC_PATH'/lib/truezip-6.jar'

echo 'Purging previous build...'
rm -rf $BIN_OUT
mkdir $BIN_OUT

#  Compiling
cd $SRC_PATH
echo 'Compiling ...'
$JAVAC_8_EXEC -encoding utf8 -classpath $CLASS_PATHs -d $BIN_OUT -sourcepath $SRC_PATH $SRC_PATH'/idyno/Idynomics.java'

# launch command
cd $DYNO_PATH'/bin'
echo 'Launching ...'
#echo "$JAVA_8_EXEC -Dfile.encoding=UTF-8 -classpath $CLASS_PATHs idyno.Idynomics"
$JAVA_8_EXEC -Dfile.encoding=UTF-8 -classpath $CLASS_PATHs idyno.Idynomics

# Tried to compare folders, created by IDEA and from terminal via:
# renaming bin folder created by IDEA as bin_idea
# and following command:
# diff -qr ./bin ./bin_idea

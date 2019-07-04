#!/bin/bash
# tested with JDK 1.8.0
# sudo dnf -y install java-1.8.0-openjdk-devel
java -version

# java 8 in Fedora is located at: /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.fc30.x86_64/bin/java
# the folder itself is available with a shortcut via /usr/lib/jvm/java-1.8.0
# the folder itself is available with a shortcut via /usr/lib/jvm/java-1.8.0-openjdk

# java 8 in Ubuntu is located at : /usr/lib/jvm/java-8-openjdk-amd64/bin/java
# the folder itself is available with a shortcut via /usr/lib/jvm/java-1.8.0-openjdk-amd64
JAVA_FOLDER=$(find '/usr/lib' -name "*java-1.8.0*" -type d)
echo $JAVA_FOLDER

JAVA_8_EXEC=$JAVA_FOLDER'/bin/java'
JAVAC_8_EXEC=$JAVA_FOLDER'/bin/javac'

# root folder of iDynoMICs
DYNO_PATH=$(dirname $(dirname $(realpath $0)))
SRC_PATH=$DYNO_PATH'/src'

# Collecting all path needed to build / compile / run
CLASS_PATHs=$DYNO_PATH'/bin'
echo $CLASS_PATHs

for jar_file in $DYNO_PATH'/src/lib/'*.jar; do
	echo $jar_file
	CLASS_PATHs=$CLASS_PATHs:$jar_file
done

cd $DYNO_PATH

#!/bin/bash
# tested with JDK 1.8.0
# sudo dnf -y install java-1.8.0-openjdk-devel
java -version

echo Content of '$PATH' variable
echo $PATH
echo Content of '$JAVA_HOME' variable
echo $JAVA_HOME


DYNO_PATH=$(dirname $(dirname $(realpath $0)))
echo iDynoMICs project is located at "$DYNO_PATH"

CLASS_PATHs=$DYNO_PATH'/bin'
echo $CLASS_PATHs

DYNO_SRC_LIB_FOLDER=$DYNO_PATH'/src/lib'

for jar_file in $DYNO_SRC_LIB_FOLDER/*.jar; do
	echo $jar_file
	CLASS_PATHs=$CLASS_PATHs:$jar_file
done

cd $DYNO_PATH
java -cp "$CLASS_PATHs" idyno.Idynomics


# Doesn work for now in full (!!!)

# Looking for Java 8
$java_folder = (Get-ChildItem -Path 'C:\Program Files\Java' -Filter "jdk*8*" -Directory).FullName
$java_bin_folder = (Join-Path -Path $java_folder -ChildPath "bin")
# Specifiyng location of java and javac
$javac = (Join-Path -Path $java_bin_folder -ChildPath "javac.exe")
$java = (Join-Path -Path $java_bin_folder -ChildPath "java.exe")


# Specifying location of root folder of project
$project_root_folder = (get-item $PSScriptRoot ).parent.FullName
# Adding folders for further look-up for jars
$root_bin = (Join-Path -Path $project_root_folder -ChildPath "bin")
$root_src = (Join-Path -Path $project_root_folder -ChildPath "src")
$root_src_lib = (Join-Path -Path $root_src -ChildPath "lib")

# collecing classes
$classpath = $root_bin

Get-ChildItem $root_src_lib -Filter *.jar | Foreach-Object {
	$j_file = $_.FullName
	echo $j_file
	$classpath += ';'  + $j_file
}


# Compiling (doesn't work for now)
# Set-Location $root_src
# $javac -encoding utf8 -classpath $classpath -d $root_bin -sourcepath $root_src $root_src'\idyno\Idynomics.java' $SRC_PATH'\iDynoOptimizer\Driver.java'

# Launching (not tried yet)
# Set-Location $root_bin
# $java -Dfile.encoding=UTF-8 -classpath $classpath idyno.Idynomics
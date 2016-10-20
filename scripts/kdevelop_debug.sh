#!/bin/bash
#
# This script is a wrapper to remote debug with kdevelop
#
# (c) 2006 Sascha Hauer, Pengutronix
#
# to debug in a typical ptxdist environment do something like this:
#
# ./kdevelop_debug.sh -e root/bin/busybox -s root \
#                     -t 192.168.23.194:1234 \
#                     -d arm-softfloat-linux-gnu-gdb
#
# (remember to recompile busybox with debugging symbols for this example)
#

usage() {
	echo
	echo "usage: $0 [OPTIONS]"
	echo
	echo "  -e <exec>      the executable to debug"
	echo "  -d <gdb>       the gdb executable to use"
	echo "  -s <solib>     the solib-absolute-prefix for gdb"
	echo "  -h <host:port> host and port for remote debugging"
	echo
}

ptxd_abspath() {
	if [ "$#" != "1" ]; then
		echo "usage: ptxd_abspath <path>"
		exit 1
	fi
	DN=`dirname $1`
	echo `cd $DN && pwd`/`basename $1`
}

while getopts "he:t:s:d:" OPT
do
    case "$OPT" in
        h)  usage
            exit 1
            ;;
	e)  executable="$OPTARG"
	    ;;
	t)  hostport="$OPTARG"
	    ;;
	s)  solib="$OPTARG"
	    ;;
	d)  debugger="$OPTARG"
	    ;;
    esac
done
shift `expr $OPTIND - 1`

if [ -z "$executable" ]; then
	echo "no executable given"
	exit 1
fi

if [ -z "$solib" ]; then
	echo "no solib dir given"
	exit 1
fi

if [ -z "$hostport" ]; then
	echo "no hostport given"
	exit 1
fi

if [ -z "$debugger" ]; then
	echo "no gdb executable given. using gdb"
	debugger=gdb
fi

executable=$(ptxd_abspath $executable)
debugdir=$(ptxd_abspath $debugdir)
solib=$(ptxd_abspath $solib)
debugger=$(which $debugger)

# our temporary project directory
wd=$(mktemp -d)

# project name, derived from the executable name
name=$(basename $executable)

# Create a minimal kdevelop project
cat << EOF > "$wd/$name.kdevelop"
<?xml version = '1.0'?>
<kdevelop>
  <general>
    <author>ptxdist</author>
    <projectmanagement>KDevCustomProject</projectmanagement>
    <primarylanguage>C</primarylanguage>
  </general>
  <kdevcustomproject>
    <run>
      <mainprogram>@MAINPROGRAMM@</mainprogram>
    </run>
  </kdevcustomproject>
  <kdevdebugger>
    <general>
      <gdbpath>@GDBPATH@</gdbpath>
      <runGdbScript>@RUN_GDB_SCRIPT@</runGdbScript>
    </general>
  </kdevdebugger>
</kdevelop>
EOF

# replace user given values
sed -i "s^@MAINPROGRAMM@^$name^" "$wd/$name.kdevelop"
sed -i "s^@RUN_GDB_SCRIPT@^$wd/run_gdb^" "$wd/$name.kdevelop"
sed -i "s^@GDBPATH@^$wd^" "$wd/$name.kdevelop"

# create a run gdb script for kdevelop
run_gdb="$wd/run_gdb"
echo "file $executable" > "$run_gdb"
echo "set solib-absolute-prefix $solib" >> "$run_gdb"
echo "target remote $hostport" >> "$run_gdb"
echo "break main" >> "$run_gdb"

# copy the executable into the project directory
cp "$executable" "$wd"

# create a link from the real debugger to the project directory
ln -s "$debugger" "$wd/gdb"

# doit
cd "$wd" && kdevelop "$wd/$name.kdevelop"

rm -rf "$wd"

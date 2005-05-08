# 
# awk script for permission fixing
#
DOPERMISSIONS='{ if ($1 == "f") printf("chmod %s .%s; chown %s.%s .%s;\n", $5, $2, $3, $4, $2); if ($1 == "n") printf("mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $5, $2, $6, $7, $8, $3, $4, $2);}'

abspath() {
	if [ $# != 1 ]; then
		echo "usage: abspath <path>"
		exit 1
	fi
	DN=`dirname $1`
	echo `cd $DN && pwd`/`basename $1`
}

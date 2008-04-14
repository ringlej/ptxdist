#!/bin/bash

usage() {
    cat <<EOF
EOF
    exit 1
}


fixup() {
    local ifs_orig;

    IFS_orig="${IFS}"
    IFS=":"

    egrep "[fnl]:" "${PERMFILE}" | while read kind file uid gid perm type major minor; do
	file="${WORKDIR}/${file#/}"

	case "${kind}" in
	    f)
		# if we have a special permission, set it also in rootfs
		if [ "${TYPE}" = "root" -a $(( 0${perm} & 07000 )) -ne 0 -o \
		    "${TYPE}" = "image" ]; then
		    chown ${uid}\:${gid} "${file}"
		    chmod ${perm}        "${file}"
		fi
		;;
	    n)
		# erase existing nodes in rootfs
		if [ "${TYPE}" = "root" -a -e "${file}" ]; then
		    rm -rf "${file}"
		fi

		mknod "${file}" ${type} ${major} ${minor}
		chown ${uid}\:${gid} "${file}"
		chmod ${perm}       "${file}"
		;;
	    l)
		;;
	esac

    done
    
    IFS="${ifs_orig}"
}



#
# main()
#
while getopts "hp:r:i:" opt; do
    case "$opt" in
	h)
	    usage
	    ;;
	p)
	    PERMFILE="${OPTARG}"
	    ;;
	r)
	    WORKDIR="${OPTARG}"
	    if [ -n "${TYPE}" ]; then
		usage;
	    fi
	    TYPE=root
	    ;;
	i)
	    WORKDIR="${OPTARG}"
	    if [ -n "${TYPE}" ]; then
		usage;
	    fi
	    TYPE=image
	    ;;
	*)
	    echo
	    echo "error: unknown option: \"${OPTARG}\""
	    echo
	    usage
	    ;;
    esac
done

if [ ! -d "${WORKDIR}" ]; then
    echo
    echo "error: specify rootdir or imagedir!"
    echo
    usage
fi

if [ ! -e "${PERMFILE}" ]; then
    echo
    echo "error: permissions file not found"
    echo
    usage
fi

fixup

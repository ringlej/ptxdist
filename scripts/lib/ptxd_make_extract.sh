#!/bin/bash

#
# -d DEST
# -s PACKET_SOURCE
# -p PACKET_DIR
# -u PACKET_URL
#
ptxd_make_extract() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh

    while getopts "s:p:u:d:" opt; do
	case "${opt}" in
	    s)
		local packet_source="${OPTARG}"
		;;
 	    p)
		local packet_dir="${OPTARG}"
		;;
	    u)
		local packet_url="${OPTARG}"
		;;
	    d)
		local dest="${OPTARG}"
		;;
	    *)
		exit 1
		;;
	esac
    done

    dest="${dest:-${BUILDDIR}}"

    case "$packet_url" in
	file://*)
	    local thing="${packet_url/file:\/\///}"
	    if [ -d "${thing}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${thing}")" "${packet_dir}"
		exit $?
	    fi
	    ;;
    esac

    if [ -z "${packet_source}" ]; then
	echo
	echo "Error: empty parameter to 'extract()'"
	echo
	exit 1
    fi

    if [ \! -d "${dest}" ]; then
	mkdir -p "${dest}" || return
    fi

    echo "extract: archive=${packet_source}"
    echo "extract: dest=${dest}"

    case "${packet_source}" in
	*gz)
	    local extract=gzip
	    ;;
	*bz2)
	    local extract=bzip2
	    ;;
	*zip)
	    echo "$(basename "${packet_source}")" >> "${STATEDIR}/packetlist"
	    unzip -q "${packet_source}" -d "${dest}"
	    exit $?
	    ;;
	*)
	    echo
	    echo "Unknown format, cannot extract!"
	    echo
	    exit 1
	    ;;
    esac

    echo "$(basename "${packet_source}")" >> "${STATEDIR}/packetlist"
    ${extract} -dc "${packet_source}" | tar -C "${dest}" -xf -

    check_pipe_status
}

export -f ptxd_make_extract

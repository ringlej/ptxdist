#!/bin/bash

#
# -d DEST
# -s PACKET_SOURCE
# -p PACKET_DIR
# -u PACKET_URL
#
ptxd_make_extract() {
    local opt

    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return 1

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
		return 1
		;;
	esac
    done

    dest="${dest:-${BUILDDIR}}"

    case "${packet_url}" in
	lndir://*)
	    local thing="${packet_url//lndir:\/\//}"
	    if [ -d "${thing}" ]; then
		echo "local directory using lndir"
		mkdir -p "${packet_dir}"
		lndir "$(ptxd_abspath "${thing}")" "${packet_dir}"
		return
	    else
		ptxd_bailout "the URL '${packet_url}' points to non existing directory."
	    fi
	    ;;
	file://*)
	    local thing="${packet_url//file:\/\//}"
	    if [ -d "${thing}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${thing}")" "${packet_dir}"
		return
	    elif [ -f "${thing}" -a -z "${packet_source}" ]; then
		echo
		echo "Using local archive"
		echo
		packet_source="${thing}"
	    else
		ptxd_bailout "the URL '${packet_url}' points to non existing directory or file."
	    fi
	    ;;
    esac

    if [ -z "${packet_source}" ]; then
	echo
	echo "Error: empty parameter to 'extract()'"
	echo
	return 1
    fi

    if [ \! -d "${dest}" ]; then
	mkdir -p "${dest}" || return
    fi

    echo "extract: archive=${packet_source}"
    echo "extract: dest=${dest}"

    ptxd_make_extract_archive "${packet_source}" "${dest}" &&
    echo "$(basename "${packet_source}")" >> "${STATEDIR}/packetlist"
}

export -f ptxd_make_extract

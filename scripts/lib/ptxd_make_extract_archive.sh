#!/bin/bash

ptxd_make_extract_archive() {
    local archive="$1"
    local dest="$2"
    local filter

    case "${archive}" in
	*gz)
	    filter="--gzip"
	    ;;
	*bz2)
	    filter="--bzip2"
	    ;;
	*lzma)
	    filter="--lzma"
	    ;;
	*xz)
	    filter="--xz"
	    ;;
	*lzop)
	    filter="--lzop"
	    ;;
	*tar|*tar.*)
	    # no filter or autodetect
	    ;;
	*zip)
	    unzip -q "${archive}" -d "${dest}"
	    return
	    ;;
	*)
	    cat >&2 <<EOF

Unknown format, cannot extract!

EOF
	    return 1
	    ;;
    esac

    tar -C "${dest}" "${filter}" -x -f "${archive}" || {
	cat >&2 <<EOF

error: extracting '${archive}' failed

EOF
	return 1
    }
}
export -f ptxd_make_extract_archive


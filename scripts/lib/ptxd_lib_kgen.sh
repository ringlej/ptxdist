#!/bin/bash
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

export PTX_KGEN_DIR="${PTXDIST_TEMPDIR}/kgen"

#
# local defined vars
#
# FIXME: use these globaly
#
PTXDIST_OVERWRITE_DIRS_MSB=( "${PTXDIST_PLATFORMCONFIGDIR}" "${PTXDIST_WORKSPACE}" "${PTXDIST_TOPDIR}" )
PTXDIST_OVERWRITE_DIRS_LSB=( "${PTXDIST_TOPDIR}" "${PTXDIST_WORKSPACE}" "${PTXDIST_PLATFORMCONFIGDIR}" )

ptxd_kgen_awk()
{
    kgen_part="${kgen_part}" \
    gawk '
	BEGIN {
	    FS = ":##[[:space:]]*SECTION=|[[:space:]]*$";
	}

	{
	    file = $1;
	    section = $2;
	    pkg = gensub(/.*\//, "", "g", file);

	    pkgs[section, pkg] = file;
	}

	END {
	    n = asorti(pkgs, sorted);

	    for (i = 1; i <= n; i++) {
		split(sorted[i], sep, SUBSEP)

		file = pkgs[sorted[i]];
		section = sep[1];
		pkg = sep[2];

		output = "'"${PTX_KGEN_DIR}/${kgen_part}"'" "/" section ".in";

#		print output ":", "source \"" file "\""
		print "source \"" file "\"" > output
	    }
	}
	'
}


ptxd_kgen_generate_sections()
{
    local dir
    {
	for dir in "${PTXDIST_OVERWRITE_DIRS_LSB[@]}"; do
	    if [ \! -d "${dir}/${kgen_part_dir}" ]; then
		continue
	    fi
	    # '! -name ".#*"' filters out emacs's lock files
	    find "${dir}/${kgen_part_dir}/" -name *.in \! -name ".#*" -print0
	done
    } | {
	#
	# if there isn't any "SECTION" in any .in-file, grep has a
	# negative return value. but this is no error, so use
	# "|| true" here
	#
	xargs -r -0 -- \
	    grep -R -H -e "^##[[:space:]]*SECTION=" || true
    } | ptxd_kgen_awk
    check_pipe_status
}


ptxd_kgen()
{
    local kgen_part="${1}"
    local kgen_part_dir="${part}"

    if [ ${#} -ne 1 ]; then
	cat <<EOF

${PROMPT}error: '${FUNCNAME}' needs one parameter

EOF
	exit 1
    fi

    # transmogrify part into subdir
    case "${kgen_part}" in
	ptx)	  kgen_part_dir="rules" ;;
	platform) kgen_part_dir="platforms" ;;
	board|user|collection) return 0 ;;
	*) cat <<EOF

${PROMPT}error: '${FUNCNAME}' doesn't support '${part}', yet

EOF
	    exit 1
    esac

    rm -rf "${PTX_KGEN_DIR}/${kgen_part}" &&
    mkdir -p "${PTX_KGEN_DIR}/${kgen_part}" &&

    ptxd_kgen_generate_sections
}

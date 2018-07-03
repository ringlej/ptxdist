#!/bin/bash
#
# Copyright (C) 2014 Sascha Hauer <s.hauer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
ptxd_lib_local_src() {
	if [ $# -ne 1 -a $# -gt 2 ]; then
		echo "Usage: local_src <package> [<directory>]"
		exit 1
	fi

	local pkgname="${1}"
	local target="${2}"
	local link="${PTXDIST_WORKSPACE}/local_src/${pkgname}${PTXDIST_PLATFORMSUFFIX}";

	if [ -z "${target}" ]; then
		echo "Removing local_src link for '${pkgname}'."
		rm -f "${link}"
		return
	fi

	mkdir -p "${PTXDIST_WORKSPACE}/local_src"

	if [ -e "${link}" -o -L "${link}" ]; then
		if [ -n "${PTX_FORCE}" ]; then
			rm "${link}" || exit 1
		else
			ptxd_bailout "'${link}' already exists. Use -f to overwrite"
		fi
	fi

	if [ ! -d "${target}" ]; then
		ptxd_bailout "'${target}' does not exist or is not a directory"
		exit 1
	fi

	case "${target}" in
	/*) ;;
	*)  target="$(ptxd_abspath "${target}")" ;;
	esac

	echo "Creating local_src link for '${pkgname}'. Package '${pkgname}' will be built from '${target}'"

	ln -s "${target}" "${link}"
}
export -f ptxd_lib_local_src

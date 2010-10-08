#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# $1: filename of the source archive to check
# $2: md5sum of the source archive to check
#
ptxd_make_check_src_impl() {
    local src="${1}"
    local md5="${2}"

    if [ -z "${src}" ]; then
	ptxd_bailout "ptxd_make_check_src called without source file."
    fi
    case "${PTXCONF_SETUP_CHECK}" in
    never)
	return
	;;
    notempty)
	[ -z "${md5}" ] && return
	;;
    esac
    # for some packages setting the md5sum in the makefile is not possible
    # e.g. for the kernel with its variable version number. Use "none" to
    # disable the check.
    if [ "${md5}" = "none" ]; then
	return
    fi

    echo "${md5}  ${src}" | md5sum --check --quiet > /dev/null 2>&1
}
export -f ptxd_make_check_src_impl

#
# verify the md5sum of the source file of the current package
#
ptxd_make_check_src() {
    ptxd_make_check_src_impl "$@" && return

    if [ -z "${2}" ]; then
	ptxd_bailout "md5sum for '${1}' missing."
    else
	ptxd_bailout "Wrong md5sum for '${1}'"
    fi
}
export -f ptxd_make_check_src

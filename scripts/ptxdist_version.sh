#!/bin/bash

#
# version definition for ptxdist
#
_ptxd_get_version()
{
    PTXDIST_VERSION_FULL="$("${PTXDIST_TOPDIR:=.}/scripts/kernel/setlocalversion" "${PTXDIST_TOPDIR}/.tarball-version")"

    local orig_IFS="${IFS}"
    local IFS="."
    set -- ${PTXDIST_VERSION_FULL}
    IFS="${orig_IFS}"

    PTXDIST_VERSION_YEAR="${1}"
    PTXDIST_VERSION_MONTH="${2}"
    PTXDIST_VERSION_BUGFIX="${3%%-*}"
    PTXDIST_VERSION_SCM="${3#*-}"

    if [ -n "${PTXDIST_VERSION_SCM}" ]; then
	PTXDIST_VERSION_PTXRC="git"
    else
	PTXDIST_VERSION_PTXRC="${PTXDIST_VERSION_YEAR}.${PTXDIST_VERSION_MONTH}"
    fi

}

_ptxd_get_version

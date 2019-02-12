#!/bin/bash
#
# Copyright (C) 2015 by Michael Olbrich <mol@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_serialize_take() {
    local readptr="ptxd_make_serialize_${pkg_stage}_readfd"
    local tmp
    if [ -n "${!readptr}" ]; then
	read -n 1 -u "${!readptr}" tmp
    fi
}
export -f ptxd_make_serialize_take

ptxd_make_serialize_put() {
    local ret=$?
    local fifo="${PTXDIST_TEMPDIR}/${pkg_stage}-fifo"
    if [ -e "${fifo}" ]; then
	echo -n '+' > "${fifo}"
    fi
    return "${ret}"
}
export -f ptxd_make_serialize_put

ptxd_make_serialize_setup() {
    local name="${1}"
    local count="${2}"
    local fifo="${PTXDIST_TEMPDIR}/${name}-fifo"
    local writeptr="ptxd_make_serialize_${name}_writefd"
    local readptr="ptxd_make_serialize_${name}_readfd"
    local writefd readfd

    if [ ! -e "${fifo}" ]; then
	mkfifo "${fifo}" || return
    fi
    echo -n "$(seq -s "+" 0 ${count} | sed 's/[^+]//g')" > "${fifo}" &
    exec {readfd}< "${fifo}" &&
    exec {writefd}> "${fifo}" &&
    eval "${readptr}"="${readfd}" &&
    eval "${writeptr}"="${writefd}" &&
    export "${readptr}" "${writeptr}"
}
export -f ptxd_make_serialize_setup

ptxd_make_serialize_init() {
    local num="${PTXDIST_PARALLELMFLAGS#-j}"
    local sync mflags jobserver

    if [ -n "${num}" ]; then
	ptxd_make_serialize_setup global "${num}" || return
	sync="${PTXDIST_OUTPUT_SYNC:+${PTXDIST_OUTPUT_SYNC}recurse}"
	jobserver="--jobserver-auth"
	if ! "${PTXCONF_SETUP_HOST_MAKE}" ${jobserver}=42,43 --help >& /dev/null; then
	    jobserver="-j --jobserver-fds"
	fi
	mflags="${jobserver}=${ptxd_make_serialize_global_readfd},${ptxd_make_serialize_global_writefd}"
	PTXDIST_PARALLELMFLAGS_INTERN="${sync} ${mflags}"
	PTXDIST_PARALLELMFLAGS_EXTERN="${sync} ${mflags}"
	PTXDIST_JOBSERVER_FLAGS="${mflags}"
	PTXDIST_PARALLEL_FLAGS="${PTXDIST_PARALLELMFLAGS}"
    else
	PTXDIST_JOBSERVER_FLAGS=
	PTXDIST_PARALLEL_FLAGS="${PTXDIST_PARALLELMFLAGS_INTERN}"
	case "${PTXDIST_PARALLELMFLAGS_INTERN}" in
	-j1) ;;
	*)
	    sync="${PTXDIST_OUTPUT_SYNC:+${PTXDIST_OUTPUT_SYNC}target --no-print-directory}"
	    PTXDIST_PARALLELMFLAGS_INTERN="${PTXDIST_PARALLELMFLAGS_INTERN} ${sync}" ;;
	esac
    fi
    export PTXDIST_JOBSERVER_FLAGS PTXDIST_PARALLEL_FLAGS

    ptxd_make_serialize_setup get 4 &&
    ptxd_make_serialize_setup extract 2
}
ptxd_make_serialize_init

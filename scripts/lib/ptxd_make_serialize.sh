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

    mkfifo "${fifo}" || return
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

    if [ -n "${num}" ]; then
	ptxd_make_serialize_setup global "${num}" || return
	local mflags="-j --jobserver-fds=${ptxd_make_serialize_global_readfd},${ptxd_make_serialize_global_writefd}"
	PTXDIST_PARALLELMFLAGS_INTERN="${mflags}"
	PTXDIST_PARALLELMFLAGS_EXTERN="${mflags}"
    fi

    ptxd_make_serialize_setup get 4 &&
    ptxd_make_serialize_setup extract 2
}
ptxd_make_serialize_init

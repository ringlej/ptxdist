#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
#
#
ptxd_init_ptxdist_path() {
    if [ "${PTXDIST_WORKSPACE}" != "${PTXDIST_PLATFORMCONFIGDIR}" ]; then
	PTXDIST_PATH="${PTXDIST_WORKSPACE}:${PTXDIST_PLATFORMCONFIGDIR}:${PTXDIST_TOPDIR}:"
    elif [ ! "${PTXDIST_WORKSPACE}" -ef "${PTXDIST_TOPDIR}" ]; then
	PTXDIST_PATH="${PTXDIST_WORKSPACE}:${PTXDIST_TOPDIR}:"
    else
	PTXDIST_PATH="${PTXDIST_WORKSPACE}:"
    fi
    export PTXDIST_PATH

    PTXDIST_PATH_PATCHES="${PTXDIST_PATH//://patches:}"
    export PTXDIST_PATH_PATCHES

    PTXDIST_PATH_RULES="${PTXDIST_PATH//://rules:}"
    export PTXDIST_PATH_RULES

    PTXDIST_PATH_PRERULES="${PTXDIST_PATH_RULES//://pre:}"
    export PTXDIST_PATH_PRERULES

    PTXDIST_PATH_POSTRULES="${PTXDIST_PATH_RULES//://post:}"
    export PTXDIST_PATH_POSTRULES

    PTXDIST_PATH_TEMPLATES="${PTXDIST_PATH_RULES//://templates:}"
    export PTXDIST_PATH_TEMPLATES

    PTXDIST_PATH_PLATFORMS="${PTXDIST_PATH//://platforms:}"
    export PTXDIST_PATH_PLATFORMS

    PTXDIST_PATH_SCRIPTS="${PTXDIST_PATH//://scripts:}"
    export PTXDIST_PATH_SCRIPTS
}


#
# initialize vars needed by PTXdist's libs
#
ptxd_lib_init() {
    ptxd_init_ptxdist_path
}
ptxd_lib_init


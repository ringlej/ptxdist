#!/bin/bash
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_lib_reproducible() {
    SOURCE_DATE_EPOCH="$(echo $(date --date="${PTXDIST_VERSION_YEAR}-${PTXDIST_VERSION_MONTH}-01 UTC" "+%s"))"
    export SOURCE_DATE_EPOCH

    PTXDIST_BUILD_TIMESTAMP="$(echo $(date --utc --date @${SOURCE_DATE_EPOCH} +%Y-%m-%dT%H:%M+0000))"
    export PTXDIST_BUILD_TIMESTAMP
}
export -f ptxd_lib_reproducible

ptxd_lib_reproducible

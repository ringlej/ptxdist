#!/bin/bash

PTXDIST_AUTOCONF_CACHE_TARGET="${PTXDIST_GEN_CONFIG_DIR}/config-target.cache"
PTXDIST_AUTOCONF_CACHE_HOST="${PTXDIST_GEN_CONFIG_DIR}/config-host.cache"

export PTXDIST_AUTOCONF_CACHE_TARGET
export PTXDIST_AUTOCONF_CACHE_HOST

ptxd_make_autoconf_cache() {
    mkdir -p -- "${PTXDIST_GEN_CONFIG_DIR}" &&

    #
    # make there no garbage in the cache for the individual cache
    # case, as long as we don't generate serious cache contents
    #
    if [ -z "${PTXCONF_SETUP_COMMON_CACHE}" ]; then
	rm -rf -- \
	    "${PTXDIST_AUTOCONF_CACHE_TARGET}" \
	    "${PTXDIST_AUTOCONF_CACHE_HOST}"
    fi &&

    touch -- \
	"${PTXDIST_AUTOCONF_CACHE_TARGET}" \
	"${PTXDIST_AUTOCONF_CACHE_HOST}"
}
ptxd_make_autoconf_cache

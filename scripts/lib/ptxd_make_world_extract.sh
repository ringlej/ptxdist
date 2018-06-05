#!/bin/bash
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# ptxd_make_world_extract
#
ptxd_make_world_extract() {
    ptxd_make_world_init || return

    if [ -z "${pkg_url}" -a -z "${pkg_src}" -o -z "${pkg_dir}" ]; then
	# no <PKG>_URL and no <PKG>_SOURCE or no <PKG>_DIR -> assume the package has nothing to extract.
	return
    fi

    if [ "${pkg_dir%/}" = "${pkg_extract_dir}" ]; then
	ptxd_bailout "<PKG>_DIR cannot be the $(ptxd_print_path ${pkg_extract_dir}). There is something wrong with the package definition."
    fi

    pkg_extract_dir="${pkg_deprecated_extract_dir:-${pkg_extract_dir}}"

    case "${pkg_url}" in
	lndir://*)
	    local url="${pkg_url//lndir:\/\//}"
	    if [ -n "${pkg_src}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a lndir:// URL!"
	    fi
	    if [ -d "${url}" ]; then
		echo "local directory using lndir"
		mkdir -p "${pkg_dir}"
		lndir "$(ptxd_abspath "${url}")" "${pkg_dir}"
		return
	    else
		ptxd_bailout "the URL '${pkg_url}' points to non existing directory."
	    fi
	    ;;
	file://*)
	    local url="$(ptxd_file_url_path "${pkg_url}")"
	    if [ -d "${url}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${url}")" "${pkg_dir}"
		return
	    elif [ -f "${url}" ]; then
		echo
		echo "Using local archive"
		echo
		pkg_src="${url}"
	    else
		ptxd_bailout "the URL '${pkg_url}' points to non existing directory or file."
	    fi
	    ;;
    esac

    mkdir -p "${pkg_extract_dir}" || return

    ptxd_make_serialize_take
    echo "\
extract: pkg_src=$(ptxd_print_path ${pkg_src})
extract: pkg_extract_dir=$(ptxd_print_path ${pkg_dir})"

    local tmpdir
    tmpdir="$(mktemp -d "${pkg_dir}.XXXXXX")"
    if ! ptxd_make_extract_archive "${pkg_src}" "${tmpdir}"; then
	rm -rf "${tmpdir}"
	ptxd_make_serialize_put
	ptxd_bailout "failed to extract '${pkg_src}'."
    fi
    local depth=$[${pkg_strip_level:=1}+1]
    if [ -e "${pkg_dir}" ]; then
	tar -C "$(dirname "${tmpdir}")" --remove-files -c "$(basename "${tmpdir}")" | \
	    tar -x --strip-components=${depth} -C "${pkg_dir}"
	check_pipe_status
    else
	mkdir -p "${pkg_dir}" &&
	find "${tmpdir}" -mindepth ${depth} -maxdepth ${depth} -print0 | \
	    xargs -0 mv -t "${pkg_dir}"
	check_pipe_status
    fi
    local ret=$?
    rm -rf "${tmpdir}"
    ptxd_make_serialize_put
    return ${ret}
}

export -f ptxd_make_world_extract

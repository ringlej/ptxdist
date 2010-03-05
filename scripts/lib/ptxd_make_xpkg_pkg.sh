#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_exist() {
    for file in "${@}"; do
	if [ ! -f "${file}" ]; then
	    echo -e "\nError: file not found: ${file}\n"
	    return 1
	fi
    done
}
export -f ptxd_exist

ptxd_install_error() {
	echo Error: "$@"
	exit 1
}
export -f ptxd_install_error

ptxd_install_setup() {
    dirs=("${ptx_nfsroot}" "${ptx_nfsroot_dbg}" "${pkg_xpkg_tmp}")
    ndirs=("${ptx_nfsroot}" "${ptx_nfsroot_dbg}")
    pdirs=("${pkg_xpkg_tmp}")
    sdirs=("${ptx_nfsroot}" "${pkg_xpkg_tmp}")
    nfs_mod="$(printf "0%o" $(( 0${mod} & ~06000 )))"

    if [ "${src}" = "-" -a -n "${dst}" ]; then
	src="${pkg_pkg_dir}/${dst}"
    fi

    if [ -n "${src}" ]; then
	local -a list

	if [ "${src}" = "--" ]; then
	    list=( \
		"${PTXDIST_WORKSPACE}/projectroot${dst}${PTXDIST_PLATFORMSUFFIX}" \
		"${PTXDIST_WORKSPACE}/projectroot${dst}" \
		"${PTXDIST_TOPDIR}/generic${dst}" \
		"${pkg_pkg_dir}/${dst}" \
		)
	else
	    list=( \
		"${src}${PTXDIST_PLATFORMSUFFIX}" \
		"${src}" \
		)
	fi

	for src in "${list[@]}"; do
	    if [ -f "${src}" ]; then
		break
	    fi
	done
    fi
}
export -f ptxd_install_setup

ptxd_install_dir() {
    local dir="$1"
    local usr="$2"
    local grp="$3"
    local mod="$4"
    local -a dirs ndirs pdirs sdirs
    local nfs_mod

    cat << EOF
install directory:
  dir=${dir}
  owner=${usr}
  group=${grp}
  permissions=${mod}
EOF

    ptxd_install_setup &&

    install -m "${nfs_mod}" -d "${ndirs[@]/%/${dir}}" &&
    install -m "${mod}" -o "${usr}" -g "${grp}" -d "${pdirs[@]/%/${dir}}" &&

    echo "f:${dir}:${usr}:${grp}:${mod}" >> "${pkg_xpkg_perms}"
}
export -f ptxd_install_dir

ptxd_install_file() {
    local src="$1"
    local dst="$2"
    local usr="$3"
    local grp="$4"
    local mod="$5"
    local strip="$6"
    local -a dirs ndirs pdirs sdirs
    local nfs_mod

    if [ "${src}" == "--" ]; then
	local cmd="alternative"
    else
	local cmd="copy"
    fi

    cat << EOF
install file:
  src=${src}
  dst=${dst}
  owner=${usr}
  group=${grp}
  permissions=${mod}
EOF

    ptxd_install_setup &&

    ptxd_exist "${src}" &&

    rm -f "${dirs[@]/%/${dst}}" &&
    for d in "${ndirs[@]/%/${dst}}"; do
	install -m "${nfs_mod}" -D "${src}" "${d}" || return
    done &&

    for d in "${pdirs[@]/%/${dst}}"; do
	install -m "${mod}" -o "${usr}" -g "${grp}" -D "${src}" "${d}" || return
    done &&

    if ! file "${sdirs[0]/%/${dst}}" | egrep -q ":.*(executable|shared object).*stripped"; then
	strip="n"
    fi &&
    case "${strip}" in
	0|n|no) ;;
	k) "${CROSS_STRIP}" --strip-debug "${sdirs[@]/%/${dst}}" ;;
	*) "${CROSS_STRIP}" -R .note -R .comment "${sdirs[@]/%/${dst}}" ;;
    esac &&

    echo "f:${dst}:${usr}:${grp}:${mod}" >> "${pkg_xpkg_perms}"
}
export -f ptxd_install_file

ptxd_install_ln() {
    local src="$1"
    local dst="$2"
    local usr="${3:-0}"
    local grp="${4:-0}"
    local -a dirs ndirs pdirs sdirs
    local nfs_mod

    cat << EOF
install link:
  src=${src}
  dst=${dst}
EOF

    ptxd_install_setup &&

    case "${src}" in
	/*) echo "Error: absolute link detected, please fix!"
	    return 1
	    ;;
	*)  ;;
    esac &&

    rm -f "${dirs[@]/%/${dst}}" &&
    install -d "${dirs[@]/%/$(dirname "${dst}")}" &&
    for d in "${dirs[@]/%/${dst}}"; do
	ln -s "${src}" "${d}" || return
    done &&

    chown --no-dereference "${usr}:${grp}" "${dirs[@]/%/${dst}}"
}
export -f ptxd_install_ln

ptxd_install_mknod() {
    local dst="$1"
    local usr="$2"
    local grp="$3"
    local mod="$4"
    local type="$5"
    local major="$6"
    local minor="$7"
    local -a dirs ndirs pdirs sdirs
    local nfs_mod

    cat << EOF
install device node:
  owner=${usr}
  group=${grp}
  permissions=${mod}
  type=${type}
  major=${major}
  minor=${minor}
  name=${dst}
EOF

    ptxd_install_setup &&

    rm -f "${pdirs[@]/%/${dst}}" &&
    for d in "${pdirs[@]/%/${dst}}"; do
	mknod -m "${mod}" "${d}" "${type}" "${major}" "${minor}" || return
    done &&
    chown "${usr}:${grp}" "${pdirs[@]/%/${dst}}" &&

    echo "n:${dst}:${usr}:${grp}:${mod}:${type}:${major}:${minor}" >> "${pkg_xpkg_perms}"
}
export -f ptxd_install_mknod

ptxd_install_copy() {
    local cmd="$1"
    shift

    case "${cmd}" in
	f) ptxd_install_file "$@" ;;
	d) ptxd_install_dir "$@" ;;
    esac ||

    ptxd_install_error "install_copy failed!"
}
export -f ptxd_install_copy

ptxd_install_alternative() {
    ptxd_install_file -- "$@" ||
    ptxd_install_error "install_alternative failed!"
}
export -f ptxd_install_alternative

ptxd_install_link() {
    ptxd_install_ln "$@" ||
    ptxd_install_error "install_link failed!"
}
export -f ptxd_install_link

ptxd_install_node() {
    ptxd_install_mknod "$@" ||
    ptxd_install_error "install_node failed!"
}
export -f ptxd_install_node

ptxd_install_replace() {
    local dst="$1"
    local placeholder="$2"
    local value="$3"
    local -a dirs ndirs pdirs sdirs
    local nfs_mod

    cat << EOF
EOF

    ptxd_install_setup &&

    ptxd_exist "${dirs[@]/%/${dst}}" &&
    sed -i -e "s,${placeholder},${value},g" "${dirs[@]/%/${dst}}" ||

    ptxd_install_error "install_replace failed!"
}
export -f ptxd_install_replace

ptxd_install_generic() {
    local file="$1"
    local dst="$2"
    local usr="$3"
    local grp="$4"

    local -a stat
    stat=( $(stat -c "%u %g %a %t %T" "${file}") ) &&
    local usr="${usr:-${stat[0]}}" &&
    local grp="${grp:-${stat[1]}}" &&
    local mod="${stat[2]}" &&
    local major="${stat[3]}" &&
    local minor="${stat[4]}" &&
    local type="$(stat -c "%F" "${file}")" &&

    case "${type}" in
        "directory")
	    ptxd_install_dir "${dst}" "${usr}" "${grp}" "${mod}"
	    ;;
        "character special file")
	    ptxd_install_mknod "${dst}" "${usr}" "${grp}" "${mod}" c "${major}" "${minor}"
	    ;;
        "block special file")
	    ptxd_install_mknod "${dst}" "${usr}" "${grp}" "${mod}" b "${major}" "${minor}"
	    ;;
        "symbolic link")
	    local src="$(readlink "${file}")" &&
	    ptxd_install_ln "${src}" "${dst}" "${usr}" "${grp}"
	    ;;
        "regular file"|"regular empty file")
	    ptxd_install_file "${file}" "${dst}" "${usr}" "${grp}" "${mod}"
	    ;;
        *)
	    echo "Error: File type '${type}' unkown!"
	    return 1
	    ;;
    esac
}
export -f ptxd_install_generic

ptxd_install_find() {
    local dir="${1%/}"
    local dstdir="${2%/}"
    local usr="${3#-}"
    local grp="${4#-}"

    test -d "${dir}" &&

    find "${dir}" -path "*/.svn" -prune -o -path "*/.git" -prune -o \
		-path "*/.pc" -prune -o -path "*/CVS" -prune -o \
		! -path "${dir}" -print | while read file; do
	local dst="${dstdir}${file#${dir}}"
	ptxd_install_generic "${file}" "${dst}" "${usr}" "${grp}" || return
    done
}
export -f ptxd_install_find

ptxd_install_tree() {
    ptxd_install_find "$@" ||
    ptxd_install_error "install_tree failed!"
}
export -f ptxd_install_tree

ptxd_install_archive() {
    local archive="$1"
    shift

    local dir="$(mktemp -d "${PTXDIST_TEMPDIR}/install_archive.XXXXXX")" &&

    ptxd_make_extract_archive "${archive}" "${dir}" &&
    ptxd_install_find "${dir}" "$@" &&

    rm -rf "${dir}" ||

    ptxd_install_error "install_archive failed!"
}
export -f ptxd_install_archive

ptxd_install_package() {
    for dir in "${pkg_pkg_dir}/"{,usr/}{bin,sbin,libexec}; do
	find "${dir}" \( -type f -o -type l \) \
		    -executable 2>/dev/null | while read file; do
	    ptxd_install_generic - "${file#${pkg_pkg_dir}}" ||
	    ptxd_install_error "install_package failed!"
	done
    done

    for dir in "${pkg_pkg_dir}/"{,usr/}lib; do
	find "${dir}" \( -type f -o -type l \) \
		    -a -name "*.so*" 2>/dev/null | while read file; do
	    ptxd_install_generic - "${file#${pkg_pkg_dir}}" ||
	    ptxd_install_error "install_package failed!"
	done
    done
}
export -f ptxd_install_package

ptxd_install_shared() {
    local src="$1"
    local dst="$2"
    local usr="$3"
    local grp="$4"
    local mod="$5"
    local filename="$(basename "${src}")"

    ptxd_install_file "${src}" "${dst}/${filename}" "${usr}" "${grp}" "${mod}" &&

    find "$(dirname "${src}")" -type l | while read file; do
	if [ "$(readlink "${file}")" = "${filename}" ]; then
	    local link="${dst}/$(basename "${file}")"
	    ptxd_install_ln "${filename}" "${link}" "${usr}" "${grp}" || return
	fi
    done
}
export -f ptxd_install_shared

ptxd_install_lib() {
    local lib="$1"
    shift

    local file="$(for dir in "${pkg_pkg_dir}/"{,usr/}lib; do
	    find "${dir}" -type f -name "${lib}.so*"; done 2>/dev/null)"
    [ -f "${file}" ] &&

    local dst="$(dirname "${file#${pkg_pkg_dir}}")" &&
    ptxd_install_shared "${file}" "${dst}" "${@}" ||
    ptxd_install_error "ptxd_install_lib failed!"
}
export -f ptxd_install_lib

ptxd_make_xpkg_pkg() {
    local pkg_xpkg_tmp="$1"
    local pkg_xpkg_cmds="$2"
    local pkg_xpkg_perms="$3"

    . "${pkg_xpkg_cmds}"
}
export -f ptxd_make_xpkg_pkg

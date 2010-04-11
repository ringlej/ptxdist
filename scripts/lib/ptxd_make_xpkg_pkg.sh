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
	if [ ! -e "${file}" ]; then
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
    # all dirs
    dirs=("${ptx_nfsroot}" "${ptx_nfsroot_dbg}" "${pkg_xpkg_tmp}")

    # nfs root dirs
    # no setuid/setguid bit here
    ndirs=("${ptx_nfsroot}" "${ptx_nfsroot_dbg}")

    # package dirs
    # this goes into the ipkg, thus full file modes here
    pdirs=("${pkg_xpkg_tmp}")

    # strip dirs
    sdirs=("${ptx_nfsroot}" "${pkg_xpkg_tmp}")

    mod_nfs="$(printf "0%o" $(( 0${mod} & ~06000 )))"
    mod_rw="$(printf "0%o" $(( 0${mod} | 0200 )))"

}
export -f ptxd_install_setup

ptxd_install_setup_src() {
    ptxd_install_setup

    if [ "${src}" = "-" -a -n "${dst}" ]; then
	src="${pkg_pkg_dir}${dst}"
    fi

    local -a list

    if [ "${cmd}" = "alternative" ]; then
	list=( \
	    "${PTXDIST_WORKSPACE}/projectroot${PTXDIST_PLATFORMSUFFIX}${src}" \
	    "${PTXDIST_WORKSPACE}/projectroot${src}${PTXDIST_PLATFORMSUFFIX}" \
	    "${PTXDIST_WORKSPACE}/projectroot${src}" \
	    "${PTXDIST_TOPDIR}/generic${src}" \
	    "${pkg_pkg_dir}${src}" \
	    "${pkg_dir}${src}" \
	    )
    else
	list=( \
	    "${src}${PTXDIST_PLATFORMSUFFIX}" \
	    "${src}" \
	    )
    fi

    for src in "${list[@]}"; do
	if [ -e "${src}" ]; then
	    return
	fi
    done

    echo -e "\nNo suitable file '${dst}' could be found in any of these locations:"
    local orig_IFS="${IFS}"
    local IFS="
"
    echo -e "${list[*]}\n"
    IFS="${orig_IFS}"

}
export -f ptxd_install_setup_src

ptxd_install_dir() {
    local dir="$1"
    local usr="$2"
    local grp="$3"
    local mod="$4"
    local -a dirs ndirs pdirs sdirs
    local mod_nfs mod_rw

    cat << EOF
install directory:
  dir=${dir}
  owner=${usr}
  group=${grp}
  permissions=${mod}
EOF

    ptxd_install_setup &&

    install -m "${mod_nfs}" -d "${ndirs[@]/%/${dir}}" &&
    install -m "${mod}" -o "${usr}" -g "${grp}" -d "${pdirs[@]/%/${dir}}" &&

    echo "f:${dir}:${usr}:${grp}:${mod}" >> "${pkg_xpkg_perms}"
}
export -f ptxd_install_dir


#
# $@: files to strip
#
# $strip: k for kernel modules
#         y for normal executables and libraries
#
# $ptx_use_sstrip: "y" use sstrip, 'n' use binutils strip
#
#
ptxd_install_file_strip() {
    local -a strip_cmd

    case "${strip:-y}${ptx_use_sstrip:-n}" in
	k*) strip_cmd=( "${CROSS_STRIP}" --strip-debug ) ;;
	yn) strip_cmd=( "${CROSS_STRIP}" -R .note -R .comment ) ;;
	yy) strip_cmd=( sstrip ) ;;
	*) ptxd_bailout "${FUNCNAME}: invalid values for strip='${strip}' or ptx_use_sstrip='${ptx_use_sstrip}'" ;;
    esac

    #
    # create hardlink so that inode stays the same during strip
    # (fixes 64 bit fakeroot <-> 32 bit strip issue)
    #
    local tmp="strip"
    local file
    for file in "${@}"; do
	ln -f "${file}" "${file}.${tmp}" || return
    done &&

    "${strip_cmd[@]}" "${@}" &&
    rm -f "${@/%/.${tmp}}"
}
export -f ptxd_install_file_strip


ptxd_install_file_impl() {
    local src="$1"
    local dst="$2"
    local usr="$3"
    local grp="$4"
    local mod="$5"
    local strip="$6"
    local -a dirs ndirs pdirs sdirs
    local mod_nfs mod_rw

    ptxd_install_setup_src &&
    cat << EOF
install ${cmd}:
  src=$(ptxd_print_path "${src}")
  dst=${dst}
  owner=${usr}
  group=${grp}
  permissions=${mod}
EOF

    ptxd_exist "${src}" &&
    rm -f "${dirs[@]/%/${dst}}" &&

    # check if src is a link
    if [ -L "${src}" ]; then
	ptxd_pedantic "file '${src}' is a link" &&
	src="$(readlink -f "${src}")" &&
	echo "using '${src}' instead"
    fi &&

    # just install with r/w permissions for now
    for d in "${dirs[@]/%/${dst}}"; do
	install -m "${mod_rw}" -D "${src}" "${d}" || return
    done &&

    if file "${src}" | egrep -q ":.*(executable|shared object|ELF.*relocatable).*stripped"; then
	case "${strip}" in
	    0|n|no|N|NO) ;;
	    *) ptxd_install_file_strip "${sdirs[@]/%/${dst}}" ;;
	esac
    fi &&

    # now change to requested permissions
    chmod "${mod_nfs}" "${ndirs[@]/%/${dst}}" &&
    chmod "${mod}"     "${pdirs[@]/%/${dst}}" &&

    # now change to requested user and group
    chown "${usr}:${grp}" "${pdirs[@]/%/${dst}}" &&

    echo "f:${dst}:${usr}:${grp}:${mod}" >> "${pkg_xpkg_perms}"
}
export -f ptxd_install_file_impl

ptxd_install_ln() {
    local src="$1"
    local dst="$2"
    local usr="${3:-0}"
    local grp="${4:-0}"
    local -a dirs ndirs pdirs sdirs
    local mod_nfs mod_rw

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
    local mod_nfs mod_rw

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

ptxd_install_alternative() {
    local cmd="alternative"
    local src="${1}"
    local dst="${2}"
    shift 2
    ptxd_install_file_impl "${src}" "${dst:-${src}}" "${@}" ||
    ptxd_install_error "install_alternative failed!"
}
export -f ptxd_install_alternative

ptxd_install_file() {
    local cmd="file"
    ptxd_install_file_impl "$@" ||
    ptxd_install_error "install_file failed!"
}
export -f ptxd_install_file

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
    local mod_nfs mod_rw

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

#
# $1: path to spec file
#
# From linux/Documentation/filesystems/ramfs-rootfs-initramfs.txt:
#
#   file  <name> <location> <mode> <uid> <gid> [<hard links>]
#   dir   <name> <mode> <uid> <gid>
#   nod   <name> <mode> <uid> <gid> <dev_type> <maj> <min>
#   slink <name> <target> <mode> <uid> <gid>
#   pipe  <name> <mode> <uid> <gid>
#   sock  <name> <mode> <uid> <gid>
#
ptxd_install_spec() {
    local specfile="${1}"
    local type args
    local orig_IFS="${IFS}"

    ptxd_exist "${specfile}"

    while read type args; do
	set -- ${args}
	case "${type}" in
	    "file")
		local name="$1"
		local location="$2"
		local mode="$3"
		local uid="$4"
		local gid="$5"

		case "${location}" in
		    /*)
			ptxd_install_file "${location}" "${name}" "${uid}" "${gid}" "${mode}"
			;;
		    *)
			ptxd_install_alternative "/${location}" "${name}" "${uid}" "${gid}" "${mode}"
			;;
		esac
		;;

	    "dir")
		local name="$1"
		local mode="$2"
		local uid="$3"
		local gid="$4"

		ptxd_install_dir "${name}" "${uid}" "${gid}" "${mode}"
		;;

	    "nod")
		local name="$1"
		local mode="$2"
		local uid="$3"
		local gid="$4"
		local dev_type="$5"
		local maj="$6"
		local min="$7"

		ptxd_install_node "${name}" "${uid}" "${gid}" "${mode}" "${dev_type}" "${maj}" "${min}"
		;;

	    "slink")
		local name="$1"
		local target="$2"
		local mode="$3"
		local uid="$4"
		local gid="$5"

		ptxd_install_link "${name}" "${target}" "${uid}" "${gid}"
		;;

	    "pipe"|"sock")
		ptxd_install_error "${type} not supported: ${type} ${args}"
		;;

	    \#*|"")
		;;
	    *)
		ptxd_install_error "Unknown type ${type}"
		;;
	esac
    done < "${specfile}"
}
export -f ptxd_install_spec

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

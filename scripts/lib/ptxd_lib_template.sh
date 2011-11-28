#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

if echo | read -i foo -p bar -e > /dev/null 2>&1; then
	_ptxd_can_read_initial=1
fi
export _ptxd_can_read_initial
#
# Read a variable from user input
#
# $1 prompt
# $2 variable name
# $3 optional default value (used if supported)
#
ptxd_template_read() {
    local -a iargs
    if [ -n "$_ptxd_can_read_initial" -a -n "${3}" ]; then
	iargs=( "-i" "${3}" )
    fi
    local prompt="${PTXDIST_LOG_PROMPT}${1}"
    for (( i=$[30-$(wc -c <<< $1)]; $i ; i=$[i-1] )); do
	prompt="${prompt}."
    done
    read -e -p "${prompt}: " "${iargs[@]}" "${2}" &&
    export "${2}"
}

ptxd_template_read_name() {
    ptxd_template_read "enter package name" package_name
    export package_filename="${package_name}"
    export package="$(tr "[A-Z]" "[a-z]" <<< "${package_name}")"
    export packagedash="$(tr "[_]" "[\-]" <<< "${package}")"
    export PACKAGE="$(tr "[a-z-]" "[A-Z_]" <<< "${package_name}")"
}
export -f ptxd_template_read_name

ptxd_template_check_existing() {
    if ptxd_in_path PTXDIST_PATH_RULES "${package_name}.make"; then
	export ptxd_template_have_existing=1
	action="${action}-existing-target"
	template="${template}-existing-target"
    else
	unset ptxd_template_have_existing
    fi
}
export -f ptxd_template_check_existing

ptxd_template_read_version() {
    if [ -z "${ptxd_template_have_existing}" ]; then
	ptxd_template_read "enter version number" VERSION
    fi
}
export -f ptxd_template_read_version

ptxd_template_read_url() {
    if [ -z "${ptxd_template_have_existing}" ]; then
	ptxd_template_read "enter URL of basedir" URL
	ptxd_template_read "enter suffix" SUFFIX
    fi
}
export -f ptxd_template_read_url

ptxd_template_read_author() {
    ptxd_template_read "enter package author" AUTHOR \
	"${PTXCONF_SETUP_USER_NAME} <${PTXCONF_SETUP_USER_EMAIL}>"
}
export -f ptxd_template_read_author

ptxd_template_read_section() {
    local section_name="${1:-project_specific}"
    ptxd_template_read "enter package section" section "${section_name}"
}
export -f ptxd_template_read_section

ptxd_template_read_basic() {
    ptxd_template_read_name &&
    ptxd_template_read_version
}
export -f ptxd_template_read_basic

ptxd_template_read_remote() {
    ptxd_template_read_basic &&
    ptxd_template_read_url &&
    ptxd_template_read_author &&
    ptxd_template_read_section
}
export -f ptxd_template_read_remote

ptxd_template_read_remote_existing() {
    ptxd_template_read_name &&
    ptxd_template_check_existing &&
    ptxd_template_read_version &&
    ptxd_template_read_url &&
    ptxd_template_read_author &&
    ptxd_template_read_section
}
export -f ptxd_template_read_remote_existing

ptxd_template_read_local() {
    ptxd_template_read_basic &&
    ptxd_template_read_author &&
    ptxd_template_read_section
}
export -f ptxd_template_read_local

ptxd_template_setup_class() {
    export AUTOCONF_CLASS="${1}"
    export class="${action}-"
    export CLASS="$(tr "[a-z-]" "[A-Z_]" <<< "${class}")"
}
export -f ptxd_template_setup_class

ptxd_template_filter() {
    local template_file="${1}"
    local filename="${2}"
    if [ ! -f "${template_file}" ]; then
	echo
	echo "${PTXDIST_LOG_PROMPT}warning: template '${template_file}' does not exist"
	echo
	continue
    fi

    if [ -f "${filename}" ]; then
	echo
	local overwrite
	read -e -p "${PTXDIST_LOG_PROMPT}warning: ${filename} does already exist, overwrite? [y/n] " overwrite
	if [ "${overwrite}" != "y" ]; then
	echo "${PTXDIST_LOG_PROMPT}aborted."
	echo
	exit
	fi
    fi
    mkdir -p "$(dirname "${filename}")"
    ptxd_replace_magic "${template_file}" > "${filename}" || return
}
export -f ptxd_template_filter

ptxd_template_write_rules() {
    local template_suffix
    for template_suffix in "make" "in"; do
	local template_file="${TEMPLATESDIR}/${template}-${template_suffix}"
	local filename="${PTXDIST_WORKSPACE}/rules/${class}${package_filename}.${template_suffix}"
	ptxd_template_filter "${template_file}" "${filename}"
    done
}
export -f ptxd_template_write_rules

ptxd_template_write_src() {
    local dst="${PTXDIST_WORKSPACE}/local_src/${package}${VERSION:+-${VERSION}}"

    if [ -d "${dst}" ]; then
	return
    fi

    echo
    local r
    read -e -p "${dst#${PTXDIST_WORKSPACE}/} does not exist, create? [Y/n] " r
    case "${r}" in
	y|Y|"") ;;
	*) return ;;
    esac

    mkdir -p "${dst}" &&
    tar -C "${template_src}" -cf - --exclude .svn . | \
	tar -C "${dst}" -xvf - &&

    if [ ! -e "${dst}/wizard.sh" ]; then
	return
    fi &&

    ( cd "${dst}" && bash wizard.sh "${package}" ) &&
    rm -f "${dst}/wizard.sh"
}
export -f ptxd_template_write_src

ptxd_template_src_base() {
    ptxd_template_read_local &&
    ptxd_template_write_rules &&
    ptxd_template_write_src
}
export -f ptxd_template_src_base

ptxd_template_autoconf_base() {
    template=template-src-autoconf
    ptxd_template_src_base
}
export -f ptxd_template_autoconf_base

ptxd_template_new() {
# start a new shell here, so we can export everything for ptxd_replace_magic
(
    export action="${1}"
    export template="template-${action}"
    export template_src="${RULESDIR}/templates/${action}"
    export YEAR="$(date +%Y)"

    local func="ptxd_template_new_${action}"
    if ! declare -F | grep -q "${func}$"; then
	ptxd_template_help
	return
    fi
    echo
    echo "${PTXDIST_LOG_PROMPT}creating a new '${action}' package:"
    echo
    "${func}"
)
}
export -f ptxd_template_new

ptxd_template_help() {
    echo
    echo "usage: 'ptxdist newpackage <type>', where type is:"
    echo
    set -- "${ptxd_template_help_list[@]}"
    while [ $# -gt 0 ]; do
	while [ -z "${1}" ]; do
	    echo
	    shift
	done
	printf "  %-24s %s\n" "${1}" "${2}"
	shift 2
    done
    echo
}
export -f ptxd_template_help
export -a ptxd_template_help_list

#
# action functions
#

ptxd_template_new_host() {
    template=template-class
    ptxd_template_setup_class HOST_ &&
    ptxd_template_read_remote_existing &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_host
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="host"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for development host"

ptxd_template_new_target() {
    ptxd_template_read_remote &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_target
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="target"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for embedded target"

ptxd_template_new_cross() {
    template=template-class
    ptxd_template_setup_class HOST_CROSS_ &&
    ptxd_template_read_remote_existing &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_cross
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="cross"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create cross development package"

ptxd_template_new_klibc() {
    ptxd_template_setup_class KLIBC_ &&
    ptxd_template_read_remote_existing &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_klibc
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="klibc"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for initramfs built against klibc"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]=""

ptxd_template_new_src-autoconf-lib() {
    ptxd_template_autoconf_base
}
export -f ptxd_template_new_src-autoconf-lib
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-autoconf-lib"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create autotoolized library"

ptxd_template_new_src-autoconf-prog() {
    ptxd_template_autoconf_base
}
export -f ptxd_template_new_src-autoconf-prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-autoconf-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create autotoolized binary"

ptxd_template_new_src-autoconf-proglib() {
    ptxd_template_autoconf_base
}
export -f ptxd_template_new_src-autoconf-proglib
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-autoconf-proglib"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create autotoolized binary+library"

ptxd_template_new_src-cmake-prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src-cmake-prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-cmake-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create cmake binary"

ptxd_template_new_src-qmake-prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src-qmake-prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-qmake-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create qmake binary"

ptxd_template_new_src-linux-driver() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src-linux-driver
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-linux-driver"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create a linux kernel driver"

ptxd_template_new_src-make-prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src-make-prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-make-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create a plain makefile binary"

ptxd_template_new_src-stellaris() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src-stellaris
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-stellaris"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create stellaris firmware"

ptxd_template_new_font() {
    ptxd_template_read_remote &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_font
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="font"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create a font package"

ptxd_template_new_file() {
    ptxd_template_read_local &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_file
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="file"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package to install existing files"

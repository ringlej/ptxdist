#!/bin/bash
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# parse "license_files" line
#
# out:
#
# $file = path to file containing license
# $startline = first line of license
# $endline = last line of license
# $md5 = md5sum of license
# $guess = 'yes' if the file was not specified explicitly
#
ptxd_make_world_parse_license_files() {
    local orig_ifs="${IFS}"
    IFS=";"
    set -- ${@}
    IFS="${orig_ifs}"
    unset orig_ifs

    file=""
    filename=""
    startline="1"
    endline="$"
    md5=""
    encoding=""
    guess=""

    while [ ${#} -ne 0 ]; do
	local arg="${1}"
	shift

	case "${arg}" in
	    "file://"*)
		file="${arg##file://}"
		;;
	    "encoding="*)
		encoding="${arg##encoding=}"
		;;
	    "beginline="*)
		startline="${arg##beginline=}"
		;;
	    "startline="*)
		startline="${arg##startline=}"
		;;
	    "endline="*)
		endline="${arg##endline=}"
		;;
	    "md5="*)
		md5="${arg##md5=}"
		;;
	    "guess="*)
		guess="${arg##guess=}"
		;;
	    *)
		ptxd_bailout "unknown option '${arg}'"
		;;
	esac
    done

    if [[ "${file}" == /* ]]; then
	filename="$(basename "${file}")"
    else
	filename="${file}"
	file="${pkg_dir}/${file}"
    fi

    if [ ! -e "${file}" ]; then
	ptxd_bailout "

license file '$(ptxd_print_path "${file}")'
not found
"
    fi
}
export -f ptxd_make_world_parse_license_files

#
# Generate a "license_files" line for packages without it.
# This is done searching for file names typically used for licenses.
#
# out:
#
# $pkg_license_files = new "license_files" line if empty before
#
ptxd_make_world_license_expand() {
    local -a licenses

    [ -n "${pkg_license_files}" ] && return

    exec {fd}< <(md5sum "${pkg_dir}/COPYING"* "${pkg_dir}/LICENSE"* 2>/dev/null)
    while read md5 file <&${fd}; do
	file="${file#${pkg_dir}/}"
	licenses[${#licenses[@]}]="file://${file};md5=${md5}"
	pkg_license_files="${pkg_license_files} file://${file};md5=${md5};guess=yes"
    done
    exec {fd}<&-
}
export -f ptxd_make_world_license_expand

#
# escape string for latex
#
ptxd_make_latex_escape() {
    local s="${1}"
    s="${s//_/\\_}"
    s="${s//&/\\&}"
    echo "${s}"
}
export -f ptxd_make_latex_escape

#
# generate a latex chapter for the package
#
# in:
#
# $pkg_license = the license string
# $pkg_license_texts/$pkg_license_texts_guessed = license text files
#
ptxd_make_world_license_write() {
    local guess
    local brl='{' brr='}'
    local pkg_chapter="$(ptxd_make_latex_escape ${pkg_label})"
    local packages_url="${pkg_url}"
    local packages_md5="${pkg_md5}"
    local -a flags=( "${!pkg_license_flags[@]}" )
    local -a index=( "${!pkg_license_flags[@]}" )
    flags=( "${flags[@]/#/\\nameref${brl}}" )
    flags=( "${flags[@]/%/${brr}}" )
    pkg_chapter="${pkg_chapter#host-}"
    pkg_chapter="${pkg_chapter#cross-}"
    index=( "${index[@]/#/\\index[}" )
    index=( "${index[@]/%/]${brl}${pkg_chapter}${brr}}" )

    case "${pkg_license}" in
	*proprietary*)
	    pkg_chapter="${pkg_chapter} *** Proprietary License!"
	    packages_url="*not available*"
	    packages_md5="*not available*"
	    ;;
	*unknown*)
	    pkg_chapter="${pkg_chapter} *** Unknown License!"
	    ;;
	*ignore*)
	# ignore this package, e.g. do not list it in the report
	    return 0
	    ;;
    esac

    cat <<- EOF
		\chapter{${pkg_chapter}\label{${pkg_label}}}

		\begin{description}
		\item[Package:] $(ptxd_make_latex_escape "${pkg_label}") $(ptxd_make_latex_escape "${pkg_version}")
		\item[License:] $(ptxd_make_latex_escape "${pkg_license}")
		\iflicensereport
		${index[*]}
		\item[Flags:] $(ptxd_make_latex_escape "${flags[*]}")
		\item[URL:] \begin{flushleft}$(ptxd_make_latex_escape "${packages_url}")\end{flushleft}
		\item[MD5:] {\ttfamily ${packages_md5}}
		\fi
		\end{description}
	EOF

    if [ -n "${pkg_dot}" ]; then
	cat <<- EOF
		\iflicensereport
		\begin{figure}[!ht]
		\centering
		\hspace*{-0.5in}\maxsizebox{0.9\paperwidth}{!}{
		\input{${pkg_tex#${ptx_report_dir}/}}}
		\caption{Dependency tree for $(ptxd_make_latex_escape "${pkg_label}")}
		\label{${pkg_label}-deps}
		\end{figure}
		\fi
	EOF
    fi

    for license in "${pkg_license_texts[@]}" - "${pkg_license_texts_guessed[@]}"; do
	if [ "${license}" = "-" ]; then
	    guess="\iflicensereport [automatically found]\fi"
	    continue
	fi
	title="$(basename "${license}")"
	cat <<- EOF
		\section{$(ptxd_make_latex_escape "${title}")${guess}}
		\begin{small}
		\begin{spverbatim}
	EOF
	if [ -f "${license}.utf-8" ]; then
	    cat "${license}.utf-8"
	else
	    cat "${license}"
	fi | sed -e 's/\f/\n/g'
	check_pipe_status || return
	cat <<- EOF
		\end{spverbatim}
		\end{small}
	EOF
    done
}
export -f ptxd_make_world_license_write

ptxd_make_world_license_yaml() {
    cat << EOF
flags: ${!pkg_license_flags[@]}
licenses: ${pkg_license}
md5: ${pkg_md5}
name: ${pkg_label}
section: ${pkg_section}
url: ${pkg_url}
version: ${pkg_version}
license-files:
EOF
    local guess="no"
    for license in "${pkg_license_texts[@]}" - "${pkg_license_texts_guessed[@]}"; do
	if [ "${license}" = "-" ]; then
	    guess="yes"
	    continue
	fi
    cat << EOF
  $(basename "${license}"):
    guessed: ${guess}
    file: ${license}
    md5: $(sed -n "s/\(.*\)  $(basename "${license}")\$/\1/p" "${pkg_license_dir}/license/MD5SUM")
EOF
    done
}
export -f ptxd_make_world_license_yaml

# Copy all patches according to the series file
# $1 full path to the series file
# $2 source directory
# $3 destination directory
#
ptxd_make_world_copy_patch_files() {
    local patch para junk

    echo -n "Copy patches for package: '${pkg_label}'..."
    while read patch para junk; do
	local cat

	case "${patch}" in
	    ""|"#"*) continue ;;	# skip empty lines and comments
	    *) ;;
	esac

	cp ${2}/${patch} ${3} && check_pipe_status || return
	pushd "${3}" > /dev/null &&
	md5sum ${patch} >> MD5SUM 2>/dev/null &&
	popd > /dev/null &&
# copy only the plain content without the metadata
	echo "${patch}" >> "${3}/series"
    done < "${1}"
    pushd "${3}" > /dev/null &&
    md5sum series >> MD5SUM 2>/dev/null &&
    popd > /dev/null &&
    echo "done"

    return 0
}
export -f ptxd_make_world_copy_patch_files

#
# If the package was patched, ensure the patches are part of the release report
# $1 path to the extracted and patched sources [1]
# $2 base directory where to copy the patches to (without the trailing 'patches')
#
# [1] assumed here is the existance of the '.ptxdist' directory which contains
#     the selected patch stack if any
ptxd_make_world_copy_patches() {
   local patches_directory=""
   local series_file=""

   if [ -d "${1}/.ptxdist" ]; then
	if [ -d "${1}/.ptxdist/patches" ]; then
	    patches_directory=`readlink -n "${1}/.ptxdist/patches"`
	    series_file=`readlink -n "${1}/.ptxdist/series"`
	    if [ -d ${patches_directory} ]; then
		mkdir -p "${2}/patches" &&
	        ptxd_make_world_copy_patch_files "${series_file}" "${patches_directory}" "${2}/patches" ||
		ptxd_bailout "

Failed to copy the required patches from '${patches_directory}' to '${2}/patches'.
"
	    fi
	else
	    ptxd_bailout "

Patched sources do not follow the PTXdist style. '${1}/.ptxdist/patches' not found.
"
	fi
    fi

    return 0
}
export -f ptxd_make_world_copy_patches

#
# Define a section the license type falls in
# $1 License string or list of license strings from the package's rule file
#
ptxd_create_section_from_license()
{
    local -A section
    local orig_IFS="${IFS}"
    IFS=$'(), '

    for license in ${1}; do
	local deprecated="false"
	local osi="false"
	local exception="false"
	# remove the 'or later' modifier
	license="${license%+}"
	if ptxd_make_spdx "${license}"; then
	    if [ "${deprecated}" == "true" ]; then
		section[deprecated]="true"
	    elif [ "${osi}" == "true" ]; then
		section[osi-conform]="true"
	    elif [ "${exception}" != "true" ]; then
		section[misc]="true"
	    fi
	    continue;
	fi
	case "${license}" in
	*proprietary*)
	    section[proprietary]="true"
	    ;;
	*unknown*)
	    section[unknown]="true"
	    ;;
	public_domain)
	    section[public_domain]="true"
	    ;;
	ignore) # META packages
	    echo ignore
	    return 0
	    ;;
	AND|OR|WITH|"")
	    ;;
	*)
	    section[other]="true"
	    ;;
	esac
    done

    IFS="${orig_IFS}"

    if [ ${#section[@]} -eq 1 ]; then
	echo "${!section[@]}"
	return 0
    fi
    if [ "${section[deprecated]}" = "true" ]; then
	echo "deprecated"
    elif [ "${section[other]}" = "true" ]; then
	echo "other"
    else
	echo "mixed"
    fi
    return 0
}
export -f ptxd_create_section_from_license

ptxd_make_world_license_add_flag() {
    local flag="${1}"

    pkg_license_flags["${flag}"]="true"
    shopt -s extglob
    pkg_license="${pkg_license/*([, ])${flag}}"
    shopt -u extglob
}
export -f ptxd_make_world_license_add_flag

ptxd_make_world_license_flags() {
    local orig_IFS="${IFS}"
    IFS=$'(), '

    for license in ${pkg_license}; do
	case "${license}" in
	ignore)
	    ptxd_make_world_license_add_flag nosource
	    ;;
	*proprietary*)
	    ptxd_make_world_license_add_flag nosource
	    ptxd_make_world_license_add_flag nopatches
	    ;;
	BSD-*-Clause*|MIT*|X11|Apache-*)
	    ptxd_make_world_license_add_flag attribution
	    ;;
	nosource|nopatches|attribution)
	    ptxd_make_world_license_add_flag "${license}"
	    ;;
	OR)
	    ptxd_make_world_license_add_flag choice
	    ;;
	esac
    done

    IFS="${orig_IFS}"
}
export -f ptxd_make_world_license_flags

ptxd_make_world_license_init() {
    ptxd_make_world_init || return

    local name

    pkg_license="${pkg_license:-unknown}"

    ptxd_make_world_license_flags || return

    pkg_section="$(ptxd_create_section_from_license "${pkg_license}")"

    name="${pkg_label#host-}"
    name="${name#cross-}"

    pkg_license_dir="${ptx_report_dir}/${pkg_section}/${pkg_label}"
    pkg_release_dir="${ptx_release_dir}/${pkg_section}/${name}"
}
export -f ptxd_make_world_license_init
#
# extract and process all available license information
#
ptxd_make_world_license() {
    declare -A pkg_license_flags
    ptxd_make_world_license_init || return

    local arg
    local -a pkg_license_texts
    local -a pkg_license_texts_guessed
    local pkg_dot
    local pkg_dot="${pkg_license_dir}/graph.dot"
    local pkg_tex="${pkg_license_dir}/graph.tex"


    rm -rf "${pkg_license_dir}" || return

    if [ "${pkg_section}" == "ignore" ]; then
	echo "Package to be ignored: metapackage for example"
	return 0
    fi

    mkdir -p ${pkg_license_dir} &&
    echo ${pkg_section}/${pkg_label} >> "${ptx_report_dir}/package.list" &&

    ptxd_make_world_license_expand &&

    if [ -n "${pkg_license_files}" ]; then
	mkdir -p "${pkg_license_dir}/license"
    fi &&

    echo "Copy licenses for package: '${pkg_section}/${pkg_label}'..." &&
    for arg in ${pkg_license_files}; do
	local file startline endline md5 guess

	ptxd_make_world_parse_license_files "${arg}" &&

	local lic="${pkg_license_dir}/license/${filename//\//_}" &&
	sed -n "${startline},${endline}p" "${file}" > "${lic}" &&
	if [ -n "${encoding}" ]; then
	    iconv -f "${encoding}" -t "utf-8"  -o "${lic}.utf-8" "${lic}"
	fi &&

	if ! echo "${md5}  ${lic}" | md5sum --check > /dev/null 2>&1; then
	    ptxd_bailout "

checksum of license file '$(ptxd_print_path "${file}")'
changed: ${md5} -> $(md5sum "${lic}" | sed 's/ .*//')
"
	fi &&
	(
	cd "${pkg_license_dir}/license" &&
	md5sum `basename ${lic}` >> MD5SUM 2>/dev/null
	) &&
	if [ -z "${guess}" ]; then
	    pkg_license_texts[${#pkg_license_texts[@]}]="${lic}"
	else
	    pkg_license_texts_guessed[${#pkg_license_texts_guessed[@]}]="${lic}"
	fi ||
	ptxd_bailout "Failed to copy '$(ptxd_print_path "${file}")'"
    done &&

    ptxd_make_world_license_write | \
        sed -e 's/%/\\%/g' > "${pkg_license_dir}/license-report.tex" &&
    check_pipe_status &&

    ptxd_make_world_license_yaml > "${pkg_license_dir}/license-report.yaml" &&

    echo "${pkg_license}" > "${pkg_license_dir}/license-name" &&
    if [ "${#pkg_license_flags[@]}" -gt 0 ]; then
	echo "${!pkg_license_flags[@]}" > "${pkg_license_dir}/license-flags"
    fi
}
export -f ptxd_make_world_license

ptxd_make_world_release() {
    declare -A pkg_license_flags
    ptxd_make_world_license_init || return
    local src

    rm -rf "${pkg_release_dir}" || return

    if [ "${pkg_license_flags[nosource]}" = "true" ]; then
	echo "Package to be ignored: source release disabled"
	echo
	return
    fi

    mkdir -p ${pkg_release_dir} &&

    # BSP local packages do not have ${pkg_srcs} filled
    if [[ -z "${pkg_srcs}" && "${pkg_url}" =~ "file://" && -f "$(ptxd_file_url_path "${pkg_url}")" ]]; then
	# Use the URL for local archives
	pkg_srcs="$(ptxd_file_url_path "${pkg_url}")"
    fi
    if [ -z "${pkg_srcs}" ]; then
	if [ -z "${pkg_url}" ]; then
	    # FIXME no sources! This is an error
	    # does not work, since some packages (udev for example, refer to systemd and has no own sources)
	    echo "Error: unable to detect source files/archives for package '${pkg_label}'" > "${pkg_release_dir}/source"
	else
	    if [[ "${pkg_url}" =~ "file://" ]]; then
		echo "Note: this package has BSP internal source code" > "${pkg_release_dir}/source"
	    else
		if [[ "${pkg_url}" =~ "lndir://${PTXDIST_WORKSPACE}" ]]; then
		    echo "Note: this package has BSP internal source code" > "${pkg_release_dir}/source"
		else
		    echo "Warning: direct/plain sources outside the BSP are unsupported!" > "${pkg_release_dir}/source"
		fi
	    fi
	fi
    else
	for src in ${pkg_srcs}; do
	    # copy only if required
	    echo -n "Copy sources for package: '${pkg_label}', source: '$(basename "${src}")'..." &&
	    mkdir -p "${pkg_release_dir}/source" &&
	    cp ${src} "${pkg_release_dir}/source" &&
	    (
	    cd "${pkg_release_dir}/source" &&
	    md5sum `basename "${src}"` >> MD5SUM
	    ) &&
	    echo " done" || break
	done
	if [ "${pkg_license_flags[nopatches]}" != "true" ]; then
	    ptxd_make_world_copy_patches "${pkg_dir}" "${pkg_release_dir}"
	fi
    fi
}
export -f ptxd_make_world_release

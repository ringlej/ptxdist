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
    startline="1"
    endline="$"
    md5=""
    guess=""

    while [ ${#} -ne 0 ]; do
	local arg="${1}"
	shift

	case "${arg}" in
	    "file://"*)
		file="${arg##file://}"
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

    if [ ! -e "${pkg_dir}/${file}" ]; then
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
    local pkg_chapter="$(ptxd_make_latex_escape ${pkg_label})"
    pkg_chapter="${pkg_chapter#host-}"
    pkg_chapter="${pkg_chapter#cross-}"

    case "${pkg_license}" in
	*proprietary*)
	    pkg_chapter="${pkg_chapter} *** Proprietary License!"
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
		\item[Package:] $(ptxd_make_latex_escape ${pkg_label}) $(ptxd_make_latex_escape ${pkg_version})
		\item[License:] $(ptxd_make_latex_escape ${pkg_license})
		\item[URL:] \begin{flushleft}$(ptxd_make_latex_escape ${pkg_url})\end{flushleft}
		\item[MD5:] {\ttfamily ${pkg_md5}}
		\end{description}
	EOF

    if [ -n "${pkg_dot}" ]; then
	cat <<- EOF
		\begin{figure}[!ht]
		\centering
		\hspace*{-0.5in}\maxsizebox{0.9\paperwidth}{!}{
		\input{${pkg_tex}}}
		\caption{Dependency tree for $(ptxd_make_latex_escape ${pkg_label})}
		\label{${pkg_label}-deps}
		\end{figure}
	EOF
    fi

    for license in "${pkg_license_texts[@]}" - "${pkg_license_texts_guessed[@]}"; do
	if [ "${license}" = "-" ]; then
	    guess=" [automatically found]"
	    continue
	fi
	title="$(basename "${license}")"
	cat <<- EOF
		\section{$(ptxd_make_latex_escape ${title})${guess}}
		\begin{lstlisting}
	EOF
	cat "${license}" | sed -e 's/\f/\n/g'
	cat <<- EOF
		\end{lstlisting}
	EOF
    done
}
export -f ptxd_make_world_license_write

#
# extract and process all available license information
#
ptxd_make_world_license() {
    ptxd_make_world_init || return

    local arg
    local -a ptxd_reply
    local -a pkg_license_texts
    local -a pkg_license_texts_guessed
    local pkg_dot=${pkg_license_dir}/graph.dot
    local pkg_tex=${pkg_license_dir}/graph.tex
    pkg_license="${pkg_license:-unknown}"

    rm -rf "${pkg_license_dir}" &&
    mkdir -p "${pkg_license_dir}" &&

    ptxd_make_world_license_expand

    for arg in ${pkg_license_files}; do
	local file startline endline md5 guess

	ptxd_make_world_parse_license_files "${arg}" &&

	local lic="${pkg_license_dir}/${file//\//_}" &&
	sed -n "${startline},${endline}p" "${pkg_dir}/${file}" > "${lic}" &&

	if ! echo "${md5}  ${lic}" | md5sum --check > /dev/null 2>&1; then
	    ptxd_bailout "

checksum of license file '$(ptxd_print_path "${file}")'
changed: ${md5} -> $(md5sum "${lic}" | sed 's/ .*//')
"
	fi &&
	if [ -z "${guess}" ]; then
	    pkg_license_texts[${#pkg_license_texts[@]}]="${lic}"
	else
	    pkg_license_texts_guessed[${#pkg_license_texts_guessed[@]}]="${lic}"
	fi
    done &&

    ptxd_make_world_license_write | \
        sed -e 's/%/\\%/g' > "${pkg_license_dir}/license-report.tex" &&

    echo "${pkg_license}" > "${pkg_license_dir}/license-name"
}
export -f ptxd_make_world_license

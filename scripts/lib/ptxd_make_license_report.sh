#!/bin/bash
#
# Copyright (C) 2011-2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_license_report_header() {
    local project_desc="$(ptxd_get_ptxconf PTXCONF_PROJECT_VENDOR)-$(ptxd_get_ptxconf PTXCONF_PROJECT)$(ptxd_get_ptxconf PTXCONF_PROJECT_VERSION)"
    cat <<- EOF
	\documentclass[pointlessnumbers,bibtotocnumbered,openany,DIV14,paper=a4,twoside=false,listof=totoc]{scrbook}

	\usepackage{graphicx}
	\usepackage{imakeidx}
	\usepackage[xetex]{hyperref}
	\usepackage{scrtime}
	\usepackage{tikz}
	\usepackage{adjustbox}
	\usepackage{spverbatim}
	\hypersetup{colorlinks=true,linkcolor=blue,urlcolor=blue}
	\usepackage{tocstyle}
	\usetocstyle{KOMAlike}

	%% Something like this may be needed depending on the package list
	%\usepackage[CJK]{ucharclasses}
	%\usepackage{fontspec}
	%\newfontfamily\mycjk{VL-Gothic-Regular}
	%\setTransitionsForCJK{\mycjk}{}

	\newif\iflicensereport
	\licensereporttrue

	\makeindex[name=attribution,intoc,title=attribution Package Index]
	\makeindex[name=choice,intoc,title=choice Package Index]
	\makeindex[name=nosource,intoc,title=nosource Package Index]
	\makeindex[name=nopatches,intoc,title=nopatches Package Index]

	\begin{document}

	\thispagestyle{empty}
	\begin{titlepage}
	\null
	\vfill
	\begin{center}

	{\Huge \textbf{License Report}}
	{\huge \vfill for project \vfill $(ptxd_make_latex_escape "${project_desc}")}
	{\LARGE \vfill created \today, \thistime}

	\vskip 5cm

	{\huge !Attention!}
	\end{center}
	\vskip 0.5cm

	This list of licenses is automatically generated and asserts no claims to
	completeness or correctness. It is not legally binding, and comes without
	warranty of any kind. We advise a manual counter-check before
	publication or legal use.
	\vfill
	\vfill
	\end{titlepage}

	\phantomsection
	\pdfbookmark[1]{Contents}{toc}
	\tableofcontents
	EOF
}
export -f ptxd_make_license_report_header

ptxd_make_license_report_footer() {
    cat <<- EOF
	\appendix
	\chapter{Flags\label{Flags}}
	Note: This list of tags and the packages marked with them is meant
	as a starting point for further work. It is by no means complete.
	There are most likely packages that e.g. require attribution but
	are missing the corresponding flag.

	For individual packages, adding the flag name to
	\textless{}PKG\textgreater\_LICENSE
	sets the corresponding flag. To add flags to groups of packages,
	e.g. based on the package license,
	\emph{ptxd\_make\_world\_license\_expand()} can be overwritten and
	expanded.
	\section{nosource\label{nosource}}
	For packages marked with the {\it nosource} flag, the source
	archive(s) will not be part of the license compliance package.
	\section{nopatches\label{nopatches}}
	For packages marked with the {\it nopatches} flag, the patches
	for this package will not be part of the license compliance
	package.
	\section{attribution\label{attribution}}
	Packages marked with the {\it attribution} flag require some sort
	of attribution. Please refer to the package license for further
	details.
	\section{choice\label{choice}}
	Packages marked with the {\it choice} flag require the licensee to
	make some kind of license choice. Please refer to the package
	license for further details.

	\printindex[attribution]
	\printindex[choice]
	\printindex[nosource]
	\printindex[nopatches]

	\listoffigures

	\end{document}
	EOF
}
export -f ptxd_make_license_report_footer

ptxd_make_license_report_build() {
    local last_md5 md5

    cd "$(dirname "${ptx_license_target_tex}")"
    while true; do
	max_print_line=1000 xelatex -halt-on-error "${ptx_license_target_tex}" || return
	md5=$(md5sum "${ptx_license_target_tex%.tex}.aux")
	if [ "${md5}" == "${last_md5}" ]; then
	    break
	fi
	last_md5="${md5}"
    done
}
export -f ptxd_make_license_report_build

# $1 list of packages (short names)
# We are called twice here: once for the target packages, once for the host tools
# Note: the 'package.list' contains license info for both runs
ptxd_make_license_report() {
    local -a ptxd_reply
    local ptx_license_target_tex pkg_lic pkg
    local -A ptxd_package_license_association

    # regenerate license info and sort out unused packages
    for pkg in $(cat "${ptx_report_dir}/package.list"); do
	ptxd_package_license_association[$(basename ${pkg})]=$(dirname ${pkg})
    done

    ptxd_in_path PTXDIST_PATH_SCRIPTS lib/ptxd_make_license_report.awk || return

    echo -n "Extracting package's license information and dependencies..."
    local make_license_report="${ptxd_reply}"
    (
	for pkg in "${@}"; do
	    pkg_lic=${ptxd_package_license_association[${pkg}]}
	    if [ -z ${pkg_lic} ]; then
		# sort out no used packages for this run
		continue
	    fi
	    echo "LICENSE:$(ptxd_name_to_NAME ${pkg}):${pkg}:$(<"${ptx_report_dir}/${pkg_lic}/${pkg}/license-name"):${pkg_lic}:"
	done
	for config in ptx platform; do
	    PTXDIST_DEP_TARGET="build" ptxd_kconfig dep ${config} || return
	done
    ) | gawk -f "${make_license_report}" &&
    echo "done"

    echo -n "Generating license dependencies graphs..."
    {
	echo "SHELL = bash"
	echo "%.tex: %.dot"
	echo '	@echo "  DOT2TEX `ptxd_print_path $<`"'
	echo '	@dot2tex --docpreamble="\usepackage[xetex]{hyperref}" --figonly -fpgf --autosize -o $@ $<'
	for pkg in "${@}"; do
		pkg_lic="${ptxd_package_license_association[${pkg}]}"
		if [ -z "${pkg_lic}" ]; then
			continue
		fi
		echo "all: ${ptx_report_dir}/${pkg_lic}/${pkg}/graph.tex"
	done
   } | make -f - ${PTXDIST_PARALLELMFLAGS_INTERN} all || return
   echo "done"

#
# combine all package related info into one document
#
    ptx_license_target_tex="${ptx_report_dir}/${pkg_section}/$(basename "${ptx_license_target%.pdf}.tex")"
    (
	ptxd_make_license_report_header
	for pkg in ${@}; do
		pkg_lic="${ptxd_package_license_association[${pkg}]}"
		if [ -z ${pkg_lic} ]; then
			continue
		fi
		pkg_lic="${pkg_lic}/${pkg}"
		echo "\\input{${pkg_lic#${ptx_report_dir}/${pkg_section}}/license-report.tex}"
	done
	ptxd_make_license_report_footer
    ) > "${ptx_license_target_tex}"

    ptxd_make_license_report_build
#    mv "${ptx_license_target_tex%.tex}.pdf" "${ptx_license_target}"
}
export -f ptxd_make_license_report

ptxd_make_license_compliance_header() {
    local project_desc="$(ptxd_get_ptxconf PTXCONF_PROJECT_VENDOR)-$(ptxd_get_ptxconf PTXCONF_PROJECT)$(ptxd_get_ptxconf PTXCONF_PROJECT_VERSION)"
    cat <<- EOF
	\documentclass[pointlessnumbers,bibtotocnumbered,openany,DIV14,paper=a4,twoside=false,listof=totoc]{scrbook}

	\usepackage{graphicx}
	\usepackage[xetex]{hyperref}
	\usepackage{scrtime}
	\usepackage{tikz}
	\usepackage{adjustbox}
	\usepackage{spverbatim}
	\hypersetup{colorlinks=true,linkcolor=blue,urlcolor=blue}
	\usepackage{tocstyle}
	\usetocstyle{KOMAlike}

	%% Something like this may be needed depending on the package list
	%\usepackage[CJK]{ucharclasses}
	%\usepackage{fontspec}
	%\newfontfamily\mycjk{VL-Gothic-Regular}
	%\setTransitionsForCJK{\mycjk}{}

	\newif\iflicensereport
	\licensereportfalse

	\begin{document}

	\thispagestyle{empty}
	\begin{titlepage}
	\null
	\vfill
	\begin{center}

	{\Huge \textbf{Open Source Software Licenses}}
	{\huge \vfill for project \vfill $(ptxd_make_latex_escape "${project_desc}")}
	{\LARGE \vfill created \today, \thistime}

	\vskip 5cm

	{\huge !Attention!}
	\end{center}
	\vskip 0.5cm

	This list of licenses is automatically generated and asserts no claims to
	completeness or correctness. It is not legally binding, and comes without
	warranty of any kind. We advise a manual counter-check before
	publication or legal use.
	\vfill
	\vfill
	\end{titlepage}

	\phantomsection
	\pdfbookmark[1]{Contents}{toc}
	\tableofcontents
	EOF
}
export -f ptxd_make_license_compliance_header

ptxd_make_license_compliance_footer() {
    cat <<- EOF
	\end{document}
	EOF
}
export -f ptxd_make_license_compliance_footer

ptxd_make_license_compliance_pdf() {
    local -a ptxd_reply
    local ptx_license_target_tex pkg_lic pkg
    local -A ptxd_package_license_association

    # regenerate license info and sort out unused packages
    for pkg in $(cat "${ptx_report_dir}/package.list"); do
	ptxd_package_license_association[$(basename ${pkg})]=$(dirname ${pkg})
    done

#
# combine all package related info into one document
#
    ptx_license_target_tex="${ptx_report_dir}/${pkg_section}/$(basename "${ptx_license_target%.pdf}.tex")"
    (
	ptxd_make_license_compliance_header
	for pkg in ${@}; do
		pkg_lic="${ptxd_package_license_association[${pkg}]}"
		if [ -z "${pkg_lic}" -o "${pkg_lic}" = "proprietary" ]; then
			continue
		fi
		pkg_lic="${pkg_lic}/${pkg}"
		echo "\\input{${pkg_lic#${ptx_report_dir}/${pkg_section}}/license-report.tex}"
	done
	ptxd_make_license_compliance_footer
    ) > "${ptx_license_target_tex}"

    ptxd_make_license_report_build &&
    cp "${ptx_license_target_tex%.tex}.pdf" "${ptx_license_target}"
}
export -f ptxd_make_license_compliance_pdf

ptxd_make_license_compliance_yaml() {
    local -a ptxd_reply
    local ptx_license_target_tex pkg_lic pkg
    local -A ptxd_package_license_association

    # regenerate license info and sort out unused packages
    for pkg in $(cat "${ptx_report_dir}/package.list"); do
	ptxd_package_license_association[$(basename ${pkg})]=$(dirname ${pkg})
    done

#
# combine all package related info into one document
#
    (
	for pkg in ${@}; do
		pkg_lic="${ptxd_package_license_association[${pkg}]}"
		if [ -z "${pkg_lic}" ]; then
			continue
		fi
		pkg_lic="${pkg_lic}/${pkg}"
		echo "${pkg}:"
		sed 's/^/  /' "${ptx_report_dir}/${pkg_lic}/license-report.yaml"
	done
    ) > "${ptx_license_target}.tmp" &&
    mv "${ptx_license_target}.tmp" "${ptx_license_target}"
}
export -f ptxd_make_license_compliance_yaml


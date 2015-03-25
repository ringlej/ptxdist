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
    local project_desc="$(ptxd_get_ptxconf PTXCONF_PROJECT_VENDOR) $(ptxd_get_ptxconf PTXCONF_PROJECT) $(ptxd_get_ptxconf PTXCONF_PROJECT_VERSION)"
    cat <<- EOF
	\documentclass[pointlessnumbers,bibtotocnumbered,openany,DIV14,paper=a4,twoside=false]{scrbook}

	\usepackage{graphicx}
	\usepackage{listings}
	\usepackage[xetex]{hyperref}
	\usepackage{tocbibind}
	\usepackage{scrtime}
	\usepackage{tikz}
	\usepackage{adjustbox}
	\hypersetup{colorlinks=true,linkcolor=blue,urlcolor=blue}


	\lstset{breaklines=true,basicstyle=\footnotesize\ttfamily}

	\begin{document}

	\thispagestyle{empty}
	\begin{titlepage}
	\null
	\vfill
	\begin{center}

	{\Huge \textbf{License Report}}
	{\huge \vfill for project \vfill ${project_desc}}
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

	\tableofcontents
	EOF
}
export -f ptxd_make_license_report_header

ptxd_make_license_report_footer() {
    cat <<- EOF
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

ptxd_make_license_report() {
    local -a ptxd_reply
    local ptx_license_target_tex pkg
    ptxd_in_path PTXDIST_PATH_SCRIPTS lib/ptxd_make_license_report.awk || return
    local make_license_report="${ptxd_reply}"
    (
	for pkg in "${@}"; do
	    echo "LICENSE:$(ptxd_name_to_NAME ${pkg}):${pkg}:$(<"${ptx_report_dir}/${pkg}/license-name"):"
	done
	for config in ptx platform; do
	    PTXDIST_DEP_TARGET="build" ptxd_kconfig dep ${config} || return
	done
    ) | gawk -f "${make_license_report}" &&

    {
	echo "SHELL = bash"
	echo "%.tex: %.dot"
	echo '	@echo "  DOT2TEX `ptxd_print_path $<`"'
	echo '	@dot2tex --docpreamble="\usepackage[xetex]{hyperref}" --figonly -fpgf --autosize -o $@ $<'
	for pkg in "${@}"; do
	    echo "all: ${ptx_report_dir}/${pkg}/graph.tex"
	done
    } | make -f - ${PTXDIST_PARALLELMFLAGS_INTERN} all || return

    ptx_license_target_tex="${ptx_report_dir}/$(basename "${ptx_license_target%.pdf}.tex")"
    (
	ptxd_make_license_report_header
	for file in "${@}"; do
	    echo "\\input{${file#${ptx_report_dir}/}/license-report.tex}"
	done
	ptxd_make_license_report_footer
    ) > "${ptx_license_target_tex}"

    ptxd_make_license_report_build &&
    mv "${ptx_license_target_tex%.tex}.pdf" "${ptx_license_target}"
}
export -f ptxd_make_license_report


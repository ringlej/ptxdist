#!/bin/bash

if test -z "${PTXDIST_TOPDIR}"; then
    echo PTXDIST_TOPDIR is unset
    exit
fi

. ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh
. ${SCRIPTSDIR}/libptxdist.sh
PTXCONFIG=${PTXDIST_WORKSPACE}/ptxconfig

#
# local defined vars
#
MAP_ALL=${STATEDIR}/map_all.sh
CONFIGDEPS=${STATEDIR}/configdeps
CONFIGDEPS_MAP=${CONFIGDEPS}_map.sh


#
#
#
gen_configdeps_action () {
    yes "" | \
	${PTXDIST_TOPDIR}/scripts/kconfig/conf -O ${PTXDIST_KCONFIG} | \
	grep -e "^DEP:.*:"
};

#
# $(CONFIGDEPS): $(IN_ALL)
#
gen_configdeps() {
    ptxd_kconfig false gen_configdeps_action > ${CONFIGDEPS}
}


#
# $(CONFIGDEPS_MAP): $(CONFIGDEPS)
#
gen_configdeps_map() {
    sed -ne "s~DEP:\([^:]*\):\(.*\)~DEP_\1=\"\2\"~p" ${CONFIGDEPS} > ${CONFIGDEPS_MAP}
}


#
# $(RULESFILES_ALL): $(MAKE_ALL)
# $(RULESFILES_MAKE): $(RULESFILES)
#
gen_rulesfiles_all() {
    # PROJECTRULESDIR might be a softlink, so follow it
    local REAL_PROJECTRULESDIR
    REAL_PROJECTRULESDIR=$(readlink -f ${PROJECTRULESDIR})

    (
	if test -d ${REAL_PROJECTRULESDIR}; then
	    find ${REAL_PROJECTRULESDIR} \
		-mindepth 1 -maxdepth 1 -name "*.make"
	    find ${RULESDIR} \
		-mindepth 1 -maxdepth 1 -name "*.make" \
		`find ${REAL_PROJECTRULESDIR} \
		-mindepth 1 -maxdepth 1 -name "*.make" \
		-printf "! -name %f "`
	else 
	    find ${RULESDIR} \
		-mindepth 1 -maxdepth 1 -name "*.make"
	fi
    ) > ${RULESFILES_ALL}

    sed -e "s/\(.*\)/include \1/" ${RULESFILES_ALL} > ${RULESFILES_ALL_MAKE}
}


#
# $(MAP_all): $(RULESFILES_ALL)
#
gen_map_all() {
    grep -e "^[^#]*PACKAGES-\$(PTXCONF_.*)[[:space:]]*+=" `< ${RULESFILES_ALL}` | \
	sed -e "s~^\([^:]*\):.*PACKAGES-\$(PTXCONF_\(.*\))[[:space:]]*+=[[:space:]]*\([^[:space:]]*\)~FILENAME_\2=\"\1\"\nPACKAGE_\2=\"\3\"~" \
	> ${MAP_ALL}
}


#
# $1: package
# $2: label
# $#: deps
#
do_package_dep() {
    local package label prepare_dep targetinstall_dep dep ptxconf_dep dep_package  

    package=${1}
    label=${2}

    echo "${package}_get_deps_default = \$(${label}_SOURCE)"
    echo "${package}_extract_deps_default := \$(STATEDIR)/${package}.get"
    echo "${package}_compile_deps_default := \$(STATEDIR)/${package}.prepare"	
    echo "${package}_install_deps_default := \$(STATEDIR)/${package}.compile"

    prepare_dep="\$(STATEDIR)/${package}.extract"
    targetinstall_dep="\$(STATEDIR)/${package}.install"

    shift 2

    for dep in $*; do
	ptxconf_dep=PTXCONF_${dep}
	dep_package=PACKAGE_${dep}
	if test "${!ptxconf_dep}" = "y" -a -n "${!dep_package}"; then
	    prepare_dep="${prepare_dep} \$(STATEDIR)/${!dep_package}.install"

	    case ${!dep_package} in
		host-*|cross-*|crosstool*)
		    ;;
		*)
		    targetinstall_dep="${targetinstall_dep} \$(STATEDIR)/${!dep_package}.targetinstall"
		    ;;
	    esac
	fi
    done

    case ${package} in
	host-*|cross-*|crosstool*)
	    echo "${package}_prepare_deps_default := ${prepare_dep}"
	    ;;
	*)
	    echo "${package}_prepare_deps_default := ${prepare_dep} \$(STATEDIR)/virtual-xchain.install"
	    ;;
    esac
    echo "${package}_targetinstall_deps_default := ${targetinstall_dep}"
}


#
#
#
gen_packages_dep() {
    local label deps package filename

    la_IFS="$IFS"
    IFS=":"

    exec 3>${PACKAGE_DEP}
    exec 4>${PACKAGE_URL}
    exec 5>${RULESFILES}
    exec 6>${RULESFILES_MAKE}

    sed -ne "s/^# PTXCONF_\(.*\) is not set/\1/p" ${PTXCONFIG} | while read label; do
	package=PACKAGE_${label}
	if test -n "${!package}"; then
	    echo "${!package}_get_deps_default = \$(${label}_SOURCE)" >&3
	fi
    done
    sed -ne "s/^PTXCONF_\(.*\)=y/\1/p" ${PTXCONFIG} | while read label; do
	package=PACKAGE_${label}
	if test -n "${!package}"; then
	    deps=DEP_${label}
	    do_package_dep ${!package} ${label} ${!deps} >&3

	    filename=FILENAME_${label}
	    echo ${!filename} >&5
	    echo include ${!filename} >&6
	fi
    done

    exec 3>/dev/null
    exec 4>/dev/null
    exec 5>/dev/null
    exec 6>/dev/null

    IFS="$la_IFS"
}


#
# main()
#

. ${PTXCONFIG}

#ALL_MAKE	:= $(wildcard $(RULESDIR)/*.make) $(wildcard $(PROJECTRULESDIR)/*.make)
#ALL_IN		:= $(wildcard $(RULESDIR)/*.in) $(wildcard $(PROJECTRULESDIR)/*.in)

if test \! -e ${STATEDIR}; then
    mkdir ${STATEDIR}
fi

gen_configdeps
gen_configdeps_map

gen_rulesfiles_all
gen_map_all

. ${MAP_ALL}
. ${CONFIGDEPS_MAP}

gen_packages_dep

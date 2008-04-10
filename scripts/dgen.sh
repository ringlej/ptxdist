#!/bin/bash

if test -z "${PTXDIST_TOPDIR}"; then
    echo PTXDIST_TOPDIR is unset
    exit
fi

if test -z "${PTXDIST_WORKSPACE}"; then
    echo PTXDIST_WORKSPACE is unset
    exit
fi

. "${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh"
. "${SCRIPTSDIR}/libptxdist.sh"
PTXCONFIG=${PTXDIST_WORKSPACE}/ptxconfig
PLATFORMCONFIG=${PTXDIST_WORKSPACE}/.platformconfig

mkdir -p ${STATEDIR}

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
	"${PTXDIST_TOPDIR}/scripts/kconfig/conf" -O "${PTXDIST_KCONFIG}"
};

#
# $(CONFIGDEPS): $(IN_ALL)
#
gen_configdeps() {
    ptxd_kconfig false gen_configdeps_action > "${CONFIGDEPS}"
}


#
# $(CONFIGDEPS_MAP): $(CONFIGDEPS)
#
gen_configdeps_map() {
    sed -ne "s~DEP:\([^:]*\):\(.*\)~DEP_\1=\"\2\"~p" "${CONFIGDEPS}" > "${CONFIGDEPS_MAP}"
}


#
# $(RULESFILES_ALL): $(MAKE_ALL)
# $(RULESFILES_MAKE): $(RULESFILES)
#
gen_rulesfiles_all() {
   (
	if test -d "${PROJECTRULESDIR}"; then
	    find "${PROJECTRULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*"
	    find "${RULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*" \
		`find "${PROJECTRULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*" \
		-printf "! -name %f "`
	else
	    find "${RULESDIR}" \
		-mindepth 1 -maxdepth 1 -name "*.make" -a \! -path "*#*"
	fi
    ) > "${RULESFILES_ALL}"

    sed -e "s/\(.*\)/include \1/" "${RULESFILES_ALL}" > "${RULESFILES_ALL_MAKE}"
}


#
# $(MAP_all): $(RULESFILES_ALL)
#
gen_map_all() {
    grep -e "^[^#]*PACKAGES-\$(PTXCONF_.*)[[:space:]]*+=" `< "${RULESFILES_ALL}"` | \
	sed -e "s~^\([^:]*\):.*PACKAGES-\$(PTXCONF_\(.*\))[[:space:]]*+=[[:space:]]*\([^[:space:]]*\)~FILENAME_\2=\"\1\"\nPACKAGE_\2=\"\3\"~" \
	> "${MAP_ALL}"
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

    echo "\$(STATEDIR)/${package}.get: \$(${label}_SOURCE)"
    echo "\$(STATEDIR)/${package}.extract: \$(STATEDIR)/${package}.get"
    echo "\$(STATEDIR)/${package}.compile: \$(STATEDIR)/${package}.prepare"
    echo "\$(STATEDIR)/${package}.install: \$(STATEDIR)/${package}.compile"

    prepare_dep="\$(STATEDIR)/${package}.extract"
    targetinstall_dep="\$(STATEDIR)/${package}.install"

    shift 2

    for dep in $*; do
	ptxconf_dep=PTXCONF_${dep}
	dep_package=PACKAGE_${dep}
	if [ \( "${!ptxconf_dep}" = "y" -o "${!ptxconf_dep}" = "m" \) -a  -n "${!dep_package}" ]; then
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
	host-pkg-config)
	    echo "\$(STATEDIR)/${package}.prepare: ${prepare_dep}"
	    ;;
	host-*|cross-*|crosstool*)
	    echo "\$(STATEDIR)/${package}.prepare: ${prepare_dep} \$(STATEDIR)/virtual-host-tools.install"
	    ;;
	*)
	    echo "\$(STATEDIR)/${package}.prepare: ${prepare_dep} \$(STATEDIR)/virtual-cross-tools.install"
	    ;;
    esac
    echo "\$(STATEDIR)/${package}.targetinstall: ${targetinstall_dep}"
}


#
#
#
gen_packages_dep() {
    local label deps package filename cfgfile

    la_IFS="$IFS"
    IFS=":"

    exec 3>${PACKAGE_DEP_PRE}
    exec 4>${PACKAGE_DEP_POST}
    exec 5>${RULESFILES}
    exec 6>${RULESFILES_MAKE}

    for cfgfile in ${PTXCONFIG} ${PLATFORMCONFIG}; do
	    sed -ne "s/^# PTXCONF_\(.*\) is not set/\1/p" ${cfgfile} | while read label; do
		package=PACKAGE_${label}
		if test -n "${!package}"; then
		    echo "\$(STATEDIR)/${!package}.get: \$(${label}_SOURCE)" >&4
		fi
	    done

	    sed -ne "s/^PTXCONF_\(.*\)=[ym]/\1/p" ${cfgfile} | while read label; do
		package=PACKAGE_${label}
		if test -n "${!package}"; then
		    deps=DEP_${label}
		    do_package_dep ${!package} ${label} ${!deps} >&4

		    filename=FILENAME_${label}
		    echo ${!filename} >&5
		    echo include ${!filename} >&6
		fi
	    done
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

. "${PTXCONFIG}"
. "${PLATFORMCONFIG}"

if test \! -e "${STATEDIR}" ; then
    mkdir "${STATEDIR}"
fi

gen_configdeps
gen_configdeps_map

gen_rulesfiles_all
gen_map_all

. "${MAP_ALL}"
. "${CONFIGDEPS_MAP}"

gen_packages_dep

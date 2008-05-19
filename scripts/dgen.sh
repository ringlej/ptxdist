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

#
# local defined vars
#
PTX_MAP_ALL=${STATEDIR}/ptx_map_all.sh
CONFIGDEPS=${STATEDIR}/ptx_configdeps
CONFIGDEPS_MAP=${CONFIGDEPS}_map.sh
GEN_MAPS_ALL=${STATEDIR}/ptx_gen_map_all

#
#
#
gen_configdeps_action () {
    yes "" | \
	"${PTXDIST_TOPDIR}/scripts/kconfig/conf" -O "${kconfig}"
};

gen_configdeps_platform_action () {
    yes "" | \
	"${PTXDIST_TOPDIR}/scripts/kconfig/conf" -O "${kconfig_platform}"
};


#
# $(CONFIGDEPS): $(IN_ALL)
#
gen_configdeps() {
    local tmpdir kconfig

    ptxd_kconfig "${PTXCONFIG}" gen_configdeps_action false > "${CONFIGDEPS}"

    # if platformconfig's size is bigger than zero
    if [ -s "${PLATFORMCONFIG}" ]; then
	ptxd_kconfig "${PLATFORMCONFIG}" gen_configdeps_platform_action false >> "${CONFIGDEPS}"
    fi
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
# $(PTX_MAP_ALL): $(RULESFILES_ALL)
#
gen_map_all() {
    #
    # syslogng.make:PACKAGES-$(PTXCONF_SYSLOGNG) += syslogng
    # +-----------+                    +------+     +------+
    #       1                              2           3
    #
    # ==>
    #
    # PTX_MAP_TO_FILENAME_SYSLOGNG="syslogng.make"
    #                     +------+  +-----------+
    #                         2           1
    #
    # PTX_MAP_TO_package_SYSLOGNG="syslogng"
    #                    +------+  +------+
    #                       2          3
    #
    # PTX_MAP_TO_PACKAGE_syslogng="SYSLOGNG"
    #                    +------+  +------+
    #                       3          2
    #
    grep -e "^[^#]*PACKAGES-\$(PTXCONF_.*)[[:space:]]*+=" `< "${RULESFILES_ALL}"` > ${GEN_MAPS_ALL}
		sed -e \
		"s~^\([^:]*\):.*PACKAGES-\$(PTXCONF_\(.*\))[[:space:]]*+=[[:space:]]*\([^[:space:]]*\)~PTX_MAP_TO_FILENAME_\2=\"\1\"\nPTX_MAP_TO_package_\2=\"\3\"~" \
		${GEN_MAPS_ALL} > "${PTX_MAP_ALL}"

		sed -e \
		"s~^\([^:]*\):.*PACKAGES-\$(PTXCONF_\(.*\))[[:space:]]*+=[[:space:]]*\([^[:space:]]*\)~PTX_MAP_TO_PACKAGE_\3=\2~" \
		${GEN_MAPS_ALL} > "${PTX_MAP_ALL_MAKE}"
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

    echo "\$(STATEDIR)/${package}.extract:            \$(STATEDIR)/${package}.get"
    echo "\$(STATEDIR)/${package}.tags:               \$(STATEDIR)/${package}.prepare"
    echo "\$(STATEDIR)/${package}.compile:            \$(STATEDIR)/${package}.prepare"
    echo "\$(STATEDIR)/${package}.install:            \$(STATEDIR)/${package}.compile"
    echo "\$(STATEDIR)/${package}.targetinstall.post: \$(STATEDIR)/${package}.targetinstall"

    prepare_dep="\$(STATEDIR)/${package}.extract"
    targetinstall_dep="\$(STATEDIR)/${package}.install"

    shift 2

    for dep in $*; do
	ptxconf_dep=PTXCONF_${dep}
	dep_package=PTX_MAP_TO_package_${dep}
	if [ \( "${!ptxconf_dep}" = "y" -o "${!ptxconf_dep}" = "m" \) -a  -n "${!dep_package}" ]; then
	    prepare_dep="${prepare_dep} \$(STATEDIR)/${!dep_package}.install"

	    case ${!dep_package} in
		host-*|cross-*)
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
	host-*|cross-*)
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

    for package in "${!PTX_MAP_TO_package_@}" ; do
	label="${package#PTX_MAP_TO_package_}"
	echo "\$(STATEDIR)/${!package}.get: \$(${label}_SOURCE)" >&4
    done

    for cfgfile in "${PTXCONFIG}" "${PLATFORMCONFIG}"; do
	sed -ne "s/^PTXCONF_\(.*\)=[ym]/\1/p" "${cfgfile}" | while read label; do
	    package=PTX_MAP_TO_package_${label}
	    if test -n "${!package}"; then
		deps="DEP_${label}"
		do_package_dep ${!package} ${label} ${!deps} >&4

		filename=PTX_MAP_TO_FILENAME_${label}
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
    mkdir -p "${STATEDIR}"
fi

gen_configdeps
gen_configdeps_map

gen_rulesfiles_all
gen_map_all

. "${PTX_MAP_ALL}"
. "${CONFIGDEPS_MAP}"

gen_packages_dep

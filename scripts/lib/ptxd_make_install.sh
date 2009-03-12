#!/bin/bash


ptxd_dopermissions() {
	"${PTX_LIBDIR}/ptxd_lib_dopermissions.awk" "${@}"
}
export -f ptxd_dopermissions


#
# -p PACKET
#
ptxd_make_install_init() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return

    local opt
    while getopts "p:t:" opt; do
	case "${opt}" in
	    p)
		local packet="${OPTARG}"
		;;
	    t)
		local target="${OPTARG##*/}"
		target="${target%%.targetinstall*}"
		;;
	    *)
		return 1
		;;
	esac
    done

    if [ -z "${packet}" ]; then
    	echo
	echo "Error: empty parameter to 'install_init()'"
	echo
	return 1
    fi

#     if [ "${packet}" != "${target}" ]; then
# 	echo
# 	echo "Error: packet '${packet}' != target '${target}'"
# 	echo
# 	return 1
#     fi

    echo "install_init:	preparing for image creation..."
    local dst="${PKGDIR}/${packet}.tmp"

    rm -fr   -- \
	"${PKGDIR}/${packet}.tmp" \
	"${STATEDIR}/${packet}.perms"
    mkdir -p -- "${dst}/ipkg/CONTROL" || return

    local replace_from="ARCH"
    local replace_to="${PTXDIST_IPKG_ARCH_STRING}"

    echo -n "install_init:	@${replace_from}@ -> ${replace_to} ... "
    sed -e "s,@${replace_from}@,${replace_to},g" "${RULESDIR}/default.ipkg" > \
	"${dst}/ipkg/CONTROL/control" || return
    echo "done"

    local script rd found
    for script in \
	preinst postinst prerm postrm; do

	echo -n "install_init:	${script} "
	unset found

	for rd in \
	    "${PROJECTRULESDIR}" "${RULESDIR}"; do

	    local abs_script="${rd}/${packet}.${script}"

	    if [ -f "${abs_script}" ]; then
		install -m 0755 \
		    -D "${abs_script}" \
		    "${dst}/ipkg/CONTROL/${script}" || return

		echo "packaging: '${abs_script}'"

		if [ "${script}" = "preinst" ]; then
		    echo "install_init:	executing '${abs_script}'"
		    DESTDIR="${ROOTDIR}" /bin/sh "${abs_script}" || return
		fi

		found=true
		break
	    fi
	done

	if [ -z "${found}" ]; then
	    echo "not available"
	fi
    done
}

export -f ptxd_make_install_init


#
#
#
ptxd_make_install_fixup() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return

    local opt
    while getopts "p:f:t:" opt; do
	case "${opt}" in
	    p)
		local packet="${OPTARG}"
		;;
	    f)
		local replace_from="${OPTARG}"
		;;
	    t)
		local replace_to="${OPTARG}"
		;;
	    *)
		return 1
		;;
	esac
    done

    if [ -z "${packet}" ]; then
    	echo
	echo "Error: empty parameter to 'install_fixup()'"
	echo
	return 1
    fi

    case "${replace_from}" in
	AUTHOR)
	    replace_to="`echo ${replace_to} | sed -e 's/\([^\\]\)@/\1\\\@/g'`"
	    ;;
	PACKAGE)
	    replace_to="`echo ${replace_to} | sed -e 's/_/-/g'`"
	    ;;
	VERSION)
	    replace_to="${replace_to}${PTXCONF_PROJECT_BUILD}"
	    ;;
	DEPENDS)
	    if [ -n "${replace_to}" ]; then
		echo "we depend on nothing, don't we?"
		return 1
	    fi
	    ;;
    esac

    echo -n "install_fixup:	@${replace_from}@ -> ${replace_to} ... "
    sed -i -e "s,@$replace_from@,$replace_to,g" "${PKGDIR}/$packet.tmp/ipkg/CONTROL/control" || return
    echo "done."
}

export -f ptxd_make_install_fixup


#
#
#
ptxd_make_install_finish() {
    . ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh || return

    local opt
    while getopts "p:" opt; do
	case "${opt}" in
	    p)
		local packet="${OPTARG}"
		;;
	    f)
		local replace_from="${OPTARG}"
		;;
	    t)
		local replace_to="${OPTARG}"
		;;
	    *)
		return 1
		;;
	esac
    done

    if [ -z "${packet}" ]; then
    	echo
	echo "Error: empty parameter to 'install_finish()'"
	echo
	return 1
    fi

    if [ \! -f "${STATEDIR}/${packet}.perms" ]; then
	echo "Packet ${packet} is empty. not generating"
	rm -rf "${PKGDIR}/${packet}.tmp" || return
	return
    fi

    echo -n "install_finish:	creating package directory ... "
    (
	echo "pushd \"${PKGDIR}/${packet}.tmp/ipkg\""
	ptxd_dopermissions "${STATEDIR}/${packet}.perms"
	echo "popd"
	echo "echo \"install_finish:	packaging ipkg packet ... \""
	echo "ipkg-build ${PTXCONF_IMAGE_IPKG_EXTRA_ARGS} \"${PKGDIR}/${packet}.tmp/ipkg\" \"${PKGDIR}\""
    ) | ${FAKEROOT} -- 2>&1
    check_pipe_status || return
    rm -rf "${PKGDIR}/${packet}.tmp" || return

    echo "done."

    if [ -f "${PTXDIST_WORKSPACE}/rules/${packet}.postinst" ]; then
	echo "install_finish:	running postinst"
	DESTDIR="${ROOTDIR}" /bin/sh "${PTXDIST_WORKSPACE}/rules/${packet}.postinst"
    elif [ -f "${PTXDIST_TOPDIR}/rules/${packet}.postinst" ]; then
	echo "install_finish:	running postinst"
	DESTDIR="${ROOTDIR}" /bin/sh "${PTXDIST_TOPDIR}/rules/${packet}.postinst"
    fi
}

export -f ptxd_make_install_finish


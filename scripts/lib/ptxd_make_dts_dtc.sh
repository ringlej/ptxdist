#!/bin/bash
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_dts_dtb() {
    local dts tmp_dts deps tmp_deps dtc_include no_linemarker

    case "${dts_dts}" in
	/*)
	    if [ ! -e "${dts_dts}" ]; then
		ptxd_bailout "Device-tree '${dts_dts}' not found."
	    fi
	    dts="${dts_dts}"
	    ;;
	*)
	    if ! ptxd_in_path dts_path "${dts_dts}"; then
		ptxd_bailout "Device-tree '${dts_dts}' not found in '${dts_path}'."
	    fi
	    dts="${ptxd_reply}"
	    ;;
    esac

    if dtc -h 2>&1 | grep -q '^[[:space:]]\+-i\(,.*\)\?$'; then
	dtc_include="-i $(dirname "${dts}") -i ${dts_kernel_dir}/arch/${dts_kernel_arch}/boot/dts"
	tmp_dts="${ptx_state_dir}/$(basename "${dts}").tmp"
	no_linemarker=""
    else
	# the support for "#line ..." was added in the same relase when -i
	# was added. So we add -P only if -i is not supported.
	tmp_dts="${dts}.tmp"
	no_linemarker="-P"
    fi &&

    deps="${ptx_state_dir}/dtc.$(basename "${dts}").deps"
    tmp_deps="${PTXDIST_TEMPDIR}/dtc.$(basename "${dts}").deps"

    exec 2>&${PTXDIST_FD_LOGERR}

    echo "CPP $(ptxd_print_path "${tmp_dts}")" &&
    cpp \
	-Wp,-MD,${tmp_deps} \
	-Wp,-MT,${tmp_dts} \
	-nostdinc \
	${no_linemarker} \
	-I$(dirname "${dts}") \
	-I${dts_kernel_dir}/arch/${dts_kernel_arch}/boot/dts \
	-I${dts_kernel_dir}/arch/${dts_kernel_arch}/boot/dts/include \
	-I${dts_kernel_dir}/drivers/of/testcase-data \
	-I${dts_kernel_dir}/include \
	-undef -D__DTS__ -x assembler-with-cpp \
	-o ${tmp_dts} \
	${dts} &&

    sed -e "s;^${tmp_dts}:;${dts_dtb}:;" \
	-e 's;^ \([^ ]*\); $(wildcard \1);' "${tmp_deps}" > "${deps}" &&

    echo "DTC $(ptxd_print_path "${dts_dtb}")" &&
    dtc \
	$(ptxd_get_ptxconf PTXCONF_DTC_EXTRA_ARGS) \
	${dtc_include} \
	-d "${tmp_deps}" \
	-I dts -O dtb -b 0 \
	-o "${dts_dtb}" "${tmp_dts}" &&

    awk '{ \
	    printf "%s", $1 ;  \
	    for (i = 2; i <= NF; i++) { \
		printf " $(wildcard %s)", $i; \
	    }; \
	    print "" \
	}' "${tmp_deps}" >> "${deps}" ||

    ptxd_bailout "Unable to generate dtb file."
}
export -f ptxd_make_dts_dtb

#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_cfgchg_generate()
{
    gawk '
	BEGIN {
		FS = "=\"|\"|=| is not set";
	}

	$1 ~ /^PTX_MAP_TO_package/ {
		pkg = gensub(/PTX_MAP_TO_package_/, "", "g", $1);
#		print pkg, $2;

		pkgs[pkg] = $2;

		next;
	}

	$1 ~ /^[-\+](|# )PTXCONF/ {
		opt = gensub(/[-\+](|# )PTXCONF_/, "", "g", $1);

		if (opt ~ /.*_VERSION$/)
			ver_changed = 1;
		else
			ver_changed = 0;

		do {
			if (opt in pkgs) {
				if (ver_changed)
					pkgs_ver_changed[opt] = pkgs[opt];
				else
					pkgs_opt_changed[opt] = pkgs[opt];
				break;
			}
		} while (sub(/_+[^_]+$/, "", opt));
	}

	END {
		for (pkg in pkgs_ver_changed) {
			printf "'"${STATEDIR}/"'" pkgs_ver_changed[pkg] ".extract\0";
		}

		for (pkg in pkgs_opt_changed) {
			printf "'"${STATEDIR}/"'" pkgs_opt_changed[pkg] ".prepare\0";
			printf "'"${STATEDIR}/"'" pkgs_opt_changed[pkg] ".xpkg.map\0";
		}
	}

    ' \
	"${PTX_MAP_ALL}" \
	-
}


ptxd_cfgchg()
{
    for cfg in PTXDIST_PTXCONFIG PTXDIST_PLATFORMCONFIG; do
	local cfg_orig="${!cfg}"
	if [ \! -e "${cfg_orig}" ]; then
	    continue
	fi

	local cfg_default="${cfg}_DEFAULT"
	local cfg_old="${STATEDIR}/${!cfg_default#${PTXDIST_WORKSPACE}/}.deps_old"

	if [ -e "${cfg_old}" ]; then
	    diff -u "${cfg_old}" "${cfg_orig}" | \
		ptxd_cfgchg_generate | \
		xargs -0 -r rm -f --
	fi

	install -m644 "${cfg_orig}" "${cfg_old}" || return
    done
}

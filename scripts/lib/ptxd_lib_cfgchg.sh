#!/bin/bash

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

		do {
			if (opt in pkgs) {
				pkgs_chged[opt] = pkgs[opt];
				break;
			}
		} while (sub(/_+[^_]+$/, "", opt));
	}

	END {
		for (pkg in pkgs_chged) {
			printf "'"${STATEDIR}/"'" pkgs_chged[pkg] ".prepare\0";
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
		local cfg_default="${cfg}_DEFAULT"
		local cfg_old="${STATEDIR}/${!cfg_default#${PTXDIST_WORKSPACE}/}.deps_old"

		if [ -e "${cfg_old}" ]; then
			diff -u "${cfg_old}" "${cfg_orig}" | \
				ptxd_cfgchg_generate | \
				xargs -0 -r rm
			#check_pipe_status
		fi

		cp "${cfg_orig}" "${cfg_old}" || return
	done
}

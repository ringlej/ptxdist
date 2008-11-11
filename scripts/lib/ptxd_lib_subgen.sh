#!/bin/bash

#export PTX_SUBGEN_DIR="${STATEDIR}/subgen"
export PTX_SUBGEN_DIR="${PTXDIST_TEMPDIR}/kgen"

ptxd_subgen_generate_sections()
{
    ptxd_make_log "print-PACKAGES-m" | gawk '
	BEGIN {
		FS = "=\"|\"|=";
		sub_in = "'"${PTX_SUBGEN_DIR}"'" "/ptx_sub_selection.in";
	}

	$1 ~ /^PTX_MAP_TO_package/ {
		PKG = gensub(/PTX_MAP_TO_package_/, "", "g", $1);
		pkg = $2;

		PKGS[$2] = PKG;

		next;
	}

	$1 ~ /^PTX_MAP_DEP/ {
		PKG = gensub(/PTX_MAP_DEP_/, "", "g", $1);
		DEPS[PKG] = $2;

		next;
	}

	$1 ~ /^PACKAGES-m is/ {
		modules = $2;
	}

	END {
		n = split(modules, module, " ");
		for (i = 1; i <= n; i++) {
			pkg = module[i];
			PKG = PKGS[pkg];
#			print module[i] ": " PKG ": " DEPS[PKG];

			printf \
				"config " PKG "\n"\
				"\tbool \"" pkg "\"\n"		> sub_in;

			m = split(DEPS[PKG], DEP, ":");
			for (j = 1; j <= m; j++)
				print "\tselect " DEP[j]	> sub_in;

			printf "\n"				> sub_in;
		}

		close(sub_in);
	}

    ' \
	"${PTX_MAP_ALL}" \
	"${PTX_MAP_DEPS}" \
	-
}


ptxd_subgen()
{
#    if [ -e "${PTX_SUBGEN_DIR}" ]; then
#	rm -rf "${PTX_SUBGEN_DIR}"
#    fi

    mkdir -p "${PTX_SUBGEN_DIR}"

    ptxd_subgen_generate_sections
}

#!/bin/bash

export PTX_SUBGEN_DIR="${PTXDIST_TEMPDIR}/kgen"

ptxd_subgen_generate_sections()
{
    ptxd_make_log "print-PACKAGES-m" | gawk '
	BEGIN {
		FS = "=\"|\"|=";
		sub_in = "'"${PTX_SUBGEN_DIR}"'" "/ptx_collection.in";
	}

	$1 ~ /^PTX_MAP_TO_package/ {
		pkg = gensub(/PTX_MAP_TO_package_/, "", "g", $1);
		pkgs[$2] = pkg;

		next;
	}

	$1 ~ /^PTX_MAP_DEP/ {
		pkg = gensub(/PTX_MAP_DEP_/, "", "g", $1);
		deps[pkg] = $2;

		next;
	}

	$1 ~ /^[a-z0-9]+/ {
		n = split($1, module, " ");
		for (i = 1; i <= n; i++) {
#			print "module: " module[i] ", pkg: " pkgs[module[i]] ", deps: " deps[pkgs[module[i]]];
			module_pkgs[pkgs[module[i]]] = module[i];
		}

		next;
	}

	END {
		n = asorti(module_pkgs, sorted);

		for (i = 1; i <= n; i++) {
			pkg = sorted[i];
			pkg_lc = module_pkgs[pkg];

			printf \
				"config " pkg "\n"\
				"\t"	"bool \"" pkg_lc "\"\n"		> sub_in;

			m = split(deps[pkg], dep, ":");
			for (j = 1; j <= m; j++) {
				if (dep[j] in module_pkgs)
					print "\tselect " dep[j]	> sub_in;
			}

			printf "\n"					> sub_in;
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
    mkdir -p "${PTX_SUBGEN_DIR}"

    ptxd_subgen_generate_sections
}

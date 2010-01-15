#!/bin/bash

ptxd_colgen_generate_sections()
{
    ptxd_make_log "print-PACKAGES-m" | gawk '
	BEGIN {
		FS = "=\"|\"|=";
		col_in     = "'"${PTX_KGEN_DIR}"'" "/collection/ptx_collection.in";
		col_all_in = "'"${PTX_KGEN_DIR}"'" "/collection/ptx_collection_all.in";
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

		printf \
			"config COLLECTION_ALL\n"\
			"\t"	"bool \"select all packages \"\n"	> col_all_in;


		for (i = 1; i <= n; i++) {
			pkg = sorted[i];

			print "\tselect " pkg				> col_all_in;
		}

		printf "\n"						> col_all_in;
		close(col_all_in);

		printf "" > col_in;

		for (i = 1; i <= n; i++) {
			pkg = sorted[i];
			pkg_lc = module_pkgs[pkg];

			printf \
				"config " pkg "\n"\
				"\t"	"bool \"" pkg_lc "\"\n"		> col_in;

			m = split(deps[pkg], dep, ":");
			for (j = 1; j <= m; j++) {
				if (dep[j] in module_pkgs)
					print "\tselect " dep[j]	> col_in;
			}

			printf "\n"					> col_in;
		}
		close(col_in);
	}

    ' \
	"${PTX_MAP_ALL}" \
	"${PTX_MAP_DEPS}" \
	-
}


ptxd_colgen()
{
    mkdir -p "${PTX_KGEN_DIR}/collection" &&
    ptxd_colgen_generate_sections
}

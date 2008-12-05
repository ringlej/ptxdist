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
			if (opt in pkgs)
				print opt, "state/" pkgs[opt] ".prepare";
			
		} while (sub(/_+[^_]+$/, "", opt));
	}

	END {
	}

    ' \
	"${PTX_MAP_ALL}" \
	-
}


ptxd_cfgchg()
{
    ptxd_cfgchg_generate
}

cat | ptxd_cfgchg
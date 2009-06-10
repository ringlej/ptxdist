#!/usr/bin/gawk -f

BEGIN {
	FS = "[[:space:]]*[+]=[[:space:]]*|=";

	PTX_MAP_ALL        = ENVIRON["PTX_MAP_ALL"];
	PTX_MAP_ALL_MAKE   = ENVIRON["PTX_MAP_ALL_MAKE"];
	PTX_MAP_DEPS       = ENVIRON["PTX_MAP_DEPS"];
	PTX_DGEN_DEPS_PRE  = ENVIRON["PTX_DGEN_DEPS_PRE"];
	PTX_DGEN_DEPS_POST = ENVIRON["PTX_DGEN_DEPS_POST"];
}

/^\#|^$/ {
	next;
}

$1 ~ /^[A-Z_]*PACKAGES/ {
	PKG = gensub(/^[A-Z_]*PACKAGES-\$\(PTXCONF_([^\)]*)\)/, "\\1", "g", $1);
	PKG = gensub(/^[A-Z0-9_]*-\$\(PTXCONF_([^\)]*)\)/, "\\1", "g", PKG);

	pkg = $2;
	if (pkg ~ /[A-Z]+/) {
		print \
			"\n" \
			"error: upper case chars in package '" pkg "' detected, please fix!\n" \
			"\n\n"
			exit 1
			}

	pkgs[PKG] = pkg;

	print "PTX_MAP_TO_FILENAME_" PKG "=\"" FILENAME "\""	> PTX_MAP_ALL;
	print "PTX_MAP_TO_package_"  PKG "=\"" pkg "\""		> PTX_MAP_ALL;

	print "PTX_MAP_TO_PACKAGE_"  pkg "="   PKG		> PTX_MAP_ALL_MAKE;

	next;
}

$1 ~ /^PTX_MAP_DEP/ {
	PKG = gensub(/PTX_MAP_DEP_/, "", "g", $1);

	n = split($2, DEP, ":");
	if (n == 0)
		next;

	found = 0;
	for (i = 1; i <= n; i++) {
		if (DEP[i] in pkgs) {
			if (found == 0) {
				found = 1;
				PKG_DEPS = DEP[i];
			} else {
				PKG_DEPS = PKG_DEPS ":" DEP[i];
			}
		}

	}

	if (found == 0)
		next;

	DEPS[PKG] = PKG_DEPS;
	print "PTX_MAP_DEP_" PKG "=" PKG_DEPS			> PTX_MAP_DEPS;

	next;
}

$1 ~ /^PTXCONF_/ && $2 ~ /^[ym]$/ {
	PKG = gensub(/^PTXCONF_/, "", "g", $1);

	if (PKG in pkgs)
		pkgs_active_DEPS[PKG] = DEPS[PKG];

	next;
}

END {
	# for all pacakges
	for (PKG in pkgs) {
		# .get rules
		# in order to download sources of not selected pkgs
		#
		print "$(STATEDIR)/" pkgs[PKG] ".get: $(" PKG "_SOURCE)"					> PTX_DGEN_DEPS_POST;

		#
		# post install hooks
		#
		stage = "install";
		print PKG "_HOOK_POST_" toupper(stage) " := $(STATEDIR)/" pkgs[PKG] "." stage ".post"		> PTX_DGEN_DEPS_PRE;
	}

	# just for active ones
	for (PKG in pkgs_active_DEPS) {
		#
		# default deps
		#
		print "$(STATEDIR)/" pkgs[PKG] ".extract: "            "$(STATEDIR)/" pkgs[PKG] ".get"           > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".prepare: "            "$(STATEDIR)/" pkgs[PKG] ".extract"       > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".tags: "               "$(STATEDIR)/" pkgs[PKG] ".prepare"       > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".compile: "            "$(STATEDIR)/" pkgs[PKG] ".prepare"       > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".install: "            "$(STATEDIR)/" pkgs[PKG] ".compile"       > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".install.post: "       "$(STATEDIR)/" pkgs[PKG] ".install"       > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".targetinstall: "      "$(STATEDIR)/" pkgs[PKG] ".install.post"  > PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".targetinstall.post: " "$(STATEDIR)/" pkgs[PKG] ".targetinstall" > PTX_DGEN_DEPS_POST;

		#
		# add dep to pkgs we depend on
		#
		n = split(DEPS[PKG], DEP, ":");
		for (i = 1; i <= n; i++) {
			print \
				"$(STATEDIR)/" pkgs[PKG]    ".prepare: " \
				"$(STATEDIR)/" pkgs[DEP[i]] ".install"		> PTX_DGEN_DEPS_POST;

			#
			# only target packages have targetinstall rules
			#
			if (pkgs[DEP[i]] ~ /^host-|^cross-/)
				continue;

			print \
				"$(STATEDIR)/" pkgs[PKG]    ".targetinstall: " \
				"$(STATEDIR)/" pkgs[DEP[i]] ".targetinstall"	> PTX_DGEN_DEPS_POST;
		}

		#
		# add deps to virtual pkgs
		#
		if (pkgs[PKG] ~ /^host-pkg-config$/)
			continue;

		if (pkgs[PKG] ~ /^host-|^cross-/)
			virtual = "virtual-host-tools";
		else
			virtual = "virtual-cross-tools";

		print \
			"$(STATEDIR)/" pkgs[PKG] ".prepare: " \
			"$(STATEDIR)/" virtual   ".install"			> PTX_DGEN_DEPS_POST;
	}

	close(PTX_MAP_ALL);
	close(PTX_MAP_ALL_MAKE);
	close(PTX_MAP_DEPS);
	close(PTX_DGEN_DEPS_PRE);
	close(PTX_DGEN_DEPS_POST);
}

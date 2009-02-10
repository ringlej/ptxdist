#!/usr/bin/awk -f

BEGIN {
	FS = "[[:space:]]*[+]=[[:space:]]*|=";

	PTX_MAP_ALL        = ENVIRON["PTX_MAP_ALL"];
	PTX_MAP_ALL_MAKE   = ENVIRON["PTX_MAP_ALL_MAKE"];
	PTX_MAP_DEPS       = ENVIRON["PTX_MAP_DEPS"];
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
#	nextfile; FIXME
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
	print "PTX_MAP_DEP_" PKG "=" PKG_DEPS > PTX_MAP_DEPS;
}

$1 ~ /^PTXCONF_/ && $2 ~ /^[ym]$/ {
	PKG = gensub(/^PTXCONF_/, "", "g", $1);

	if (PKG in pkgs)
		pkgs_active_DEPS[PKG] = DEPS[PKG];

	next;
}

END {
	for (PKG in pkgs) {
		print "$(STATEDIR)/" pkgs[PKG] ".get: $(" PKG "_SOURCE)" > PTX_DGEN_DEPS_POST;
	}

	for (PKG in pkgs_active_DEPS) {
		print "$(STATEDIR)/" pkgs[PKG] ".extract:		$(STATEDIR)/" pkgs[PKG] ".get"		> PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".tags:			$(STATEDIR)/" pkgs[PKG] ".prepare"	> PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".compile:		$(STATEDIR)/" pkgs[PKG] ".prepare"	> PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".install:		$(STATEDIR)/" pkgs[PKG] ".compile"	> PTX_DGEN_DEPS_POST;
		print "$(STATEDIR)/" pkgs[PKG] ".targetinstall.post:	$(STATEDIR)/" pkgs[PKG] ".targetinstall" > PTX_DGEN_DEPS_POST;

		deps_prepare       = "$(STATEDIR)/" pkgs[PKG] ".extract";
		deps_targetinstall = "$(STATEDIR)/" pkgs[PKG] ".install";

		n = split(DEPS[PKG], DEP, ":");
		for (j = 1; j <= n; j++) {
#			print PKG ": " DEP[j];

			if (!(DEP[j] in pkgs )) {
				print "BUG: not pkg:", DEP[j];
				exit 1;
			}

			deps_prepare = deps_prepare " $(STATEDIR)/" pkgs[DEP[j]] ".install";

			if (pkgs[DEP[j]] !~ /^host-|^cross-/)
				deps_targetinstall = deps_targetinstall " $(STATEDIR)/" pkgs[DEP[j]] ".targetinstall";
		}

		if (pkgs[PKG] ~ /^host-pkg-config$/)
			print "$(STATEDIR)/" pkgs[PKG] ".prepare: " deps_prepare > PTX_DGEN_DEPS_POST;
		else if (pkgs[PKG] ~ /^host-|^cross-/)
			print "$(STATEDIR)/" pkgs[PKG] ".prepare: " deps_prepare " $(STATEDIR)/virtual-host-tools.install" > PTX_DGEN_DEPS_POST;
		else
			print "$(STATEDIR)/" pkgs[PKG] ".prepare: " deps_prepare " $(STATEDIR)/virtual-cross-tools.install" > PTX_DGEN_DEPS_POST;

		print "$(STATEDIR)/" pkgs[PKG] ".targetinstall: " deps_targetinstall > PTX_DGEN_DEPS_POST;
	}

	close(PTX_MAP_ALL);
	close(PTX_MAP_ALL_MAKE);
	close(PTX_MAP_DEPS);
	close(PTX_DGEN_DEPS_POST);
}

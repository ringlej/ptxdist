#!/usr/bin/gawk -f
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

BEGIN {
	FS = ":"
	report_dir = ENVIRON["ptx_report_dir"]
}

$1 == "DEP" {
	pkg=$2
	sub($1":"$2":", "")
	pkg_deps[pkg] = $0
}

$1 == "LICENSE" {
	# add newline after each third word
	gsub("[^ ]* [^ ]* [^ ]* ", "&\\\\ ", $4);
	gsub("_", "\\_", $4);
	licenses[$2] = $4
	raw_names[$2] = $3
	gsub("_", "\\_", $3);
	gsub("^host-", "", $3);
	gsub("^cross-", "", $3);
	names[$2] = $3
	license_type[$2] = $5
}

function make_more_dot(pkg, file, level, deps, i) {
	if (level > 3)
		return
	printf "\"%s\" [ shape=box style=\"rounded corners\" fixedsize=false texlbl=\"\\small\\begin{tabular}{c}{\\Large\\hyperref[%s]{%s}}\\\\%s\\end{tabular}\" ];\n", pkg, raw_names[pkg], gensub("_", "\\_", "g", names[pkg]), licenses[pkg]	> file
	if (!(pkg in pkg_deps))
		return
	split(pkg_deps[pkg], deps, ":")
	for (i in deps) {
		if (deps[i] == "")
			continue
		if (names[deps[i]] == "")
			continue
		if (pkg deps[i] in hit_deps)
			continue
		hit_deps[pkg deps[i]] = 1
		printf "\"%s\" -> \"%s\"[dir=back];\n", pkg, deps[i]			> file
		make_more_dot(deps[i], file, level + 1)
	}
}

function make_dot(pkg) {
	file = report_dir"/"license_type[pkg]"/"raw_names[pkg]"/graph.dot"
	delete hit_deps
	printf "digraph \"%s\" {\n", pkg	> file
	printf "rankdir=LR;\n"			> file
	printf "ratio=compress;\n"		> file
	printf "nodesep=0.1;\n"			> file
	printf "ranksep=0.1;\n"			> file
	printf "node [ shape=point fixedsize=true width=0.1 ];\n", pkg > file
	make_more_dot(pkg, file, 0)
	printf "}\n"				> file
	close(file)
}

END {
	for (pkg in licenses) {
		make_dot(pkg)
	}
}


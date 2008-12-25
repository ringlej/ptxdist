#!/usr/bin/gawk -f

BEGIN {
	prefix = "BB_CONFIG_";
}

/^[[:space:]]*(mainmenu)[[:space:]]+/ {
	gsub(/^.*$/, "# &");
}

/^[[:space:]]*(config|select|depends|default)[[:space:]]+/ {
	$0 = add_prefix($0);
}

/^[[:space:]]*source[[:space:]]+/ {
	print "SOURCE:", $2 > "/dev/stderr";
	FILENAME = "platform-phyCORE-i.MX31/build-target/busybox-1.10.4/miscutils/Config.in";
}

{
	print $0;
}

function add_prefix(IN,    in_match) {
#	depends on FOO && BAR
#       +--------+ +-------+
#           |          |
#       in_match[1]    |
#                      |
#                 in_match[4]

	match(IN, /^([[:space:]]*(config|select|default|depends([[:space:]]+on)?)[[:space:]]+)(.*)$/, in_match);

	return in_match[1] gensub(/(!)?([A-Z0-9][^[:space:]]*)/, "\\1" prefix "\\2", "g", in_match[4]);
}

END {
}

#!/usr/bin/gawk -f

#
# usage()
#
function usage() {
	printf("\n" \
	       "Usage\n" \
	       "\n" \
	       "\t"	"ptxd_lib_import <prefix> </path/to/Config.in>\n" \
	       "\n") > "/dev/stderr";
	exit 1;
}


BEGIN {
	importdir = ENVIRON["PTXDIST_IMPORTDIR"];
	if (importdir == "") {
		print "ptxd_lib_import.awk cannot be used stand-alone" > "/dev/stderr";
		usage();
	}

	if (importdir == ENVIRON["PTXDIST_WORKSPACE"]) {
		workspace = "workspace/";
	}

	prefix = ARGV[1];
	in_file = ARGV[2];
	ARGV[1] = "";

	if (prefix == "" || in_file == "")
		usage();

	prefix_lc = tolower(prefix);
	prefix = toupper(prefix_lc) "_";
	prefix = gensub(/-/, "_", "g", prefix);

	prefix_file = "config/" prefix_lc;
	in_path = gensub(/^(.*)\/.*$/, "\\1", "g", in_file);
}



#
# determine new out_file
# close old out_file
#
FNR == 1 {
        if (out_file != "")
		close(out_file);

	out_file = importdir "/" prefix_file "/" gensub(in_path "/", "", "g", FILENAME);
	out_dir = gensub(/^(.*)\/.*/, "\\1", "g", out_file);

	err = system("						\
		if [ \\! -d  \"" out_dir "\" ]; then		\
			mkdir -p -- \"" out_dir "\";		\
		fi");
	if (err != 0)
		exit(err);
}


#
# comment out mainmenu
#
/^[[:space:]]*(mainmenu)[[:space:]]+/ {
	gsub(/^.*$/, "# &");
}


#
# add the prefix to a suspicious line
#
/^[[:space:]]*(config|select|default|if|depends)[[:space:]]+/ {
	$0 = add_prefix($0);
}


#
# put "source"d file to argument, in order to convert them, too
# add prefix to sourced files
#
/^[[:space:]]*source[[:space:]]+/ {
	# remove quotes from file
	gsub(/(^"|"$)/, "", $2);
	ARGC++;
	ARGV[ARGC - 1] = in_path "/" $2;

#  source "foo/bar.in"
# +------+|+--------+|
#    |    |     |    |
#    |    |     |    |
#   \\1  \\2   \\3  \\4
#
	$0 = gensub(/^([[:space:]]*source[[:space:]]+)(")?(.*)(")?$/, "\\1" "\"" workspace prefix_file "/\\3\"", "g", $0);
}

#
# print altered line into out_file
#
{
	print $0 > out_file;
}


#
# add prefix to symbols on line
#
function add_prefix(IN,    in_match) {
#	depends on FOO && BAR
#       +--------+ +-------+
#           |          |
#       in_match[1]    |
#                      |
#                 in_match[4]

	match(IN, /^([[:space:]]*(config|select|default|if|depends([[:space:]]+on)?)[[:space:]]+)(.*)$/, in_match);

	# don't convert "N" symbols like in "default N"
	return in_match[1] gensub(/(!)?(N[A-Z0-9_]+|[A-MO-Z]+[A-Z0-9_]*)/, "\\1" prefix "\\2", "g", in_match[4]);
}


END {
	close(out_file);

	print("successfully imported: \"" in_file "\"");
}

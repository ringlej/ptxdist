#!/usr/bin/env python3
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

import subprocess
import os
import sys
import re
import difflib
import argparse
import shlex

configure_blacklist = [
	"help",
	"version",
	"quiet",
	"silent",
	"cache-file",
	"config-cache",
	"no-create",
	"srcdir",
	"prefix",
	"exec-prefix",
	"bindir",
	"sbindir",
	"libexecdir",
	"sysconfdir",
	r".*statedir",
	"runstatedir",
	"libdir",
	"includedir",
	"oldincludedir",
	"datarootdir",
	"datadir",
	"infodir",
	"localedir",
	"mandir",
	"docdir",
	"htmldir",
	"dvidir",
	"pdfdir",
	"psdir",
	"program-prefix",
	"program-suffix",
	"program-transform-name",
	"build",
	"host",
	"target",
	"option-checking",
	"FEATURE",
	"silent-rules",
	"maintainer-mode",
	"dependency-tracking",
	"fast-install",
	"libtool-lock",

	"Bsymbolic",
	"znodelete",

	"PACKAGE",
	"libiconv",
	r".*prefix",
	"pic",
	"aix-soname",
	"gnu-ld",
	"sysroot",
	"html-dir",
	"xml-catalog",

	"bash-completion-dir",

	"pkg-config-path",
	"package-name",

	"autoconf",
	"autoheader",
	"automake",
	"aclocal",

	"pkgconfigdir",

	"x-includes",
	"x-libraries",
	"ld-version-script",

	"shared",
	"static",
]

def abort(message):
	print(message)
	exit(1)

def ask_ptxdist(pkg):
	ptxdist = os.environ.get("ptxdist", "ptxdist")
	p = subprocess.Popen([ ptxdist, "-k", "make",
		"/print-%s_DIR" % pkg,
		"/print-%s_CONF_OPT" % pkg,
		"/print-%s_AUTOCONF" % pkg,
		"/print-%s_CONF_TOOL" %pkg,
		"/print-CROSS_AUTOCONF_USR"],
		stdout=subprocess.PIPE,
		universal_newlines=True)

	d = p.stdout.readline().strip()
	opt = shlex.split(p.stdout.readline().strip()) + shlex.split(p.stdout.readline().strip())
	tool = p.stdout.readline().strip()
	default = shlex.split(p.stdout.readline().strip())
	if tool == "autoconf" and not opt:
		opt = default
	if not d:
		abort("'%s' is not a valid package: %s_DIR is undefined" % (pkg, pkg))
	if not opt:
		abort("'%s' is not a autoconf package: %s_CONF_OPT and %s_AUTOCONF are undefined" % (pkg, pkg, pkg))
	return (d, opt)

def blacklist_hit(name, blacklist):
	for e in blacklist:
		if re.fullmatch(e, name):
			return True
	return False

parse_args_re = re.compile("--((enable|disable|with|without)-)?\[?([^\[=]*)(([\[=]*)([^]]*)]?)?")
def parse_configure_args(args, blacklist):
	ret = []
	for arg in args:
		groups = parse_args_re.match(arg).groups()
		if not groups[2]:
			continue
		found = False
		for e in ret:
			if groups[2] == e["name"]:
				found = True
				break
		if found:
			continue
		ret.append({"name": groups[2], "value": groups[1],
				"arg": None if not groups[4] else groups[5],
				"blacklist": blacklist_hit(groups[2], blacklist)})
	return ret

def build_args(parsed):
	build = []
	for arg in parsed:
		try:
			i = next(index for (index, d) in enumerate(parsed_pkg_conf_opt) if d["name"] == arg["name"])
			arg["blacklist"] = False
			arg["value"] = parsed_pkg_conf_opt[i]["value"]
			arg["arg"] = parsed_pkg_conf_opt[i]["arg"]
		except:
			pass
		if arg["blacklist"]:
			continue
		arg_str = "--"
		if arg["value"]:
			arg_str += arg["value"] + "-"
		arg_str += arg["name"]
		if arg["arg"] != None:
			arg_str += "=" + arg["arg"]
		build.append("\t" + arg_str + "\n")
	return build

def handle_dir(d):
	if not d:
		return (None, None, None)

	d = os.path.normpath(d)
	if not os.path.exists(d):
		abort("'%s' does not exist" % d)

	configure = d + "/configure"
	if not os.path.exists(configure):
		abort("not a autoconf package: configure script not found in '%s'" % d)
		exit(1)

	configure_args = []
	p = subprocess.Popen([ configure, "--help" ], stdout=subprocess.PIPE, universal_newlines=True)
	lines = p.stdout.read().splitlines()
	for line in lines:
		if not re.match("^\s.*", line):
			continue
		try:
			word = re.split("[\s,]", line.strip())[0]
		except:
			continue
		if word[:2] == "--":
			configure_args.append(word)
		elif ptx_pkg == "host-qemu" and re.match("  [a-z].*", line):
			configure_args.append("--enable-" + word)

	parsed = parse_configure_args(configure_args, configure_blacklist)
	args = build_args(parsed)
	label = os.path.basename(d)
	return (parsed, args, label)

def show_diff(old_opt, old_label, new_opt, new_label):
	if args.sort:
		sys.stdout.writelines(difflib.unified_diff(
			sorted(old_opt), sorted(new_opt),
			fromfile=old_label, tofile=new_label))
	else:
		sys.stdout.writelines(difflib.unified_diff(
			old_opt, new_opt,
			fromfile=old_label, tofile=new_label))

cmd = os.path.basename(sys.argv[0])
epilog = """
There are several diffent ways to configure arguments:

$ %s --pkg <pkg>
This will compare the available configure arguments of the current version
with those specified in PTXdist

$ %s --only-src /path/to/src --pkg <pkg>
This will compare the available configure arguments of the specified source
with those specified in PTXdist

$ %s --old-src /path/to/old-src --pkg <pkg>
$ %s --new-src /path/to/new-src --pkg <pkg>
This will compare the available configure arguments of the current version
with those of the specified old/new version

$ %s --new-src /path/to/new-src --old-src /path/to/old-src
This will compare the available configure arguments of the old and new
versions.

Note: this tool contains a blacklist with all options that usually don't
need to be added.

If '--pkg' is used, then the script must be called in the BSP workspace.
The environment variable 'ptxdist' can be used to specify the ptxdist
version to use.
""" % (cmd, cmd, cmd, cmd, cmd)

parser = argparse.ArgumentParser(epilog=epilog,
	formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("-p", "--pkg", help="the ptxdist package to check",
	dest="pkg")
parser.add_argument("-o", "--old-src", help="the old source directory",
	dest="old")
parser.add_argument("-n", "--new-src", help="the new source directory",
	dest="new")
parser.add_argument("-s", "--only-src", help="the only source directory",
	dest="only")
parser.add_argument("--sort", help="sort the options before comparing",
	dest="sort", action="store_true")

args = parser.parse_args()

old_dir = args.old if args.old else None
new_dir = args.new if args.new else None

if (old_dir or new_dir) and args.only:
	abort("'--old-src' and '--new-src' make no sense in combination with '--only-src'")

if args.only:
	new_dir = args.only

if args.pkg:
	ptx_pkg = args.pkg.lower().replace('_', "-")
	ptx_PKG = args.pkg.upper().replace('-', "_")
else:
	ptx_pkg = None
	ptx_PKG = None

ptx_pkg_conf_opt = []
if args.pkg:
	(d, pkg_conf_opt) = ask_ptxdist(ptx_PKG)
	ptx_pkg_label = "rules/%s.make" % ptx_pkg
	parsed_pkg_conf_opt = parse_configure_args(pkg_conf_opt, [])

	if args.only:
		pass
	elif not new_dir:
		new_dir = d
	elif not old_dir:
		old_dir = d

	for arg in pkg_conf_opt:
		ptx_pkg_conf_opt.append("\t" + arg + "\n")

else:
	parsed_pkg_conf_opt = []
	if not old_dir or not new_dir:
		abort("If no package is given, then both '--old-src' and '--new-src' must be specified")

(old_parsed_configure_args, old_pkg_conf_opt, old_pkg_label) = handle_dir(old_dir)
(new_parsed_configure_args, new_pkg_conf_opt, new_pkg_label) = handle_dir(new_dir)

if not old_pkg_conf_opt:
	show_diff(ptx_pkg_conf_opt, ptx_pkg_label, new_pkg_conf_opt, new_pkg_label)
elif not new_pkg_conf_opt:
	show_diff(old_pkg_conf_opt, old_pkg_label, ptx_pkg_conf_opt, ptx_pkg_label)
else:
	show_diff(old_pkg_conf_opt, old_pkg_label, new_pkg_conf_opt, new_pkg_label)

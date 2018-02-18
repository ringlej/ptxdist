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
import json
import io

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

meson_blacklist = [
	"c_std",
	"cpp_debugstl",
	"cpp_std",
	"b_asneeded",
	"b_colorout",
	"b_coverage",
	"b_lto",
	"b_lundef",
	"b_ndebug",
	"b_pch",
	"b_pgo",
	"b_sanitize",
	"b_staticpic",
	"bindir",
	"datadir",
	"default_library",
	"errorlogs",
	"includedir",
	"infodir",
	"layout",
	"libexecdir",
	"localedir",
	"localstatedir",
	"mandir",
	"sbindir",
	"sharedstatedir",
	"stdsplit",
	"strip",
	"sysconfdir",
	"unity",
	"warning_level",
	"werror",

	"bashcompletiondir",
]

def abort(message):
	print(message)
	print("\nSee '%s --help' for more details." % cmd)
	exit(1)

def ask_ptxdist(pkg):
	ptxdist = os.environ.get("ptxdist", "ptxdist")
	p = subprocess.Popen([ ptxdist, "-k", "make",
		"/print-%s_DIR" % pkg,
		"/print-%s_SUBDIR" % pkg,
		"/print-%s_CONF_OPT" % pkg,
		"/print-%s_AUTOCONF" % pkg,
		"/print-%s_CONF_TOOL" %pkg,
		"/print-CROSS_MESON_USR",
		"/print-CROSS_AUTOCONF_USR"],
		stdout=subprocess.PIPE,
		universal_newlines=True)

	d = p.stdout.readline().strip()
	subdir = p.stdout.readline().strip()
	opt = shlex.split(p.stdout.readline().strip()) + shlex.split(p.stdout.readline().strip())
	tool = p.stdout.readline().strip()
	if not tool and opt:
		tool = "autoconf"
	meson_default = shlex.split(p.stdout.readline().strip())
	autoconf_default = shlex.split(p.stdout.readline().strip())
	if tool == "meson" and not opt:
		opt = meson_default
	if tool == "autoconf" and not opt:
		opt = autoconf_default
	if not d:
		abort("'%s' is not a valid package: %s_DIR is undefined" % (pkg, pkg))
	if not opt:
		abort("'%s' is not a autoconf/meson package: %s_CONF_OPT and %s_AUTOCONF are undefined" % (pkg, pkg, pkg))
	return (tool, d, subdir, opt)

def blacklist_hit(name, blacklist):
	for e in blacklist:
		if re.fullmatch(e, name):
			return True
	return False

parse_args_re = re.compile("--((enable|disable|with|without|with\(out\))-)?\[?([^\[=]*)(([\[=]*)([^]]*)]?)?")
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

meson_parse_args_re = re.compile("-D(.*)=(.*)")
def parse_meson_args(args, blacklist):
	ret = []
	new_args = []
	last_args = []
	last = None
	for arg in args:
		if last != None:
			name = last
			value = arg
			# Most --* args show up as generic arguments at the end
			if name != "cross-file":
				last_args.append("-D%s=%s" % (name, value))
			last = None
		else:
			if arg.startswith("--"):
				last = arg[2:]
				continue
			else:
				last = None
			r = meson_parse_args_re.match(arg)
			if not r:
				continue
			groups = r.groups()
			name = groups[0]
			value = groups[1]
			new_args.append(arg)

		found = False
		for e in ret:
			if name == e["name"]:
				found = True
				break
		if found:
			continue
		try:
			value = json.load(io.StringIO(value))
		except:
			pass
		ret.append({"name": name, "value": value,
				"blacklist": blacklist_hit(name, blacklist)})
	return (ret, new_args + sorted(last_args))

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

def handle_dir(d, subdir):
	if not d:
		return (None, None, None)

	if subdir:
		d = os.path.join(d, subdir)

	d = os.path.normpath(d)
	if not os.path.exists(d):
		abort("'%s' does not exist" % d)

	configure = d + "/configure"
	meson_build = d + "/meson.build"
	if not os.path.exists(configure) and not os.path.exists(meson_build):
		abort("not a autoconf/meson package: configure script / meson.build file not found in '%s'" % d)
		exit(1)

	if os.path.exists(configure) and tool != "meson":
		return handle_dir_configure(d, configure)
	if os.path.exists(meson_build):
		return handle_dir_meson(d)

def handle_dir_configure(d, configure):
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

def handle_dir_meson(d):
	meson_builddir = d + "-build"
	if not os.path.exists(meson_builddir):
		abort("package must be configured")
		exit(1)
	args = []
	p = subprocess.Popen([ "meson", "introspect", meson_builddir, "--buildoptions" ], stdout=subprocess.PIPE, universal_newlines=True)
	options = json.load(p.stdout)
	for option in options:
		try:
			i = next(index for (index, d) in enumerate(parsed_pkg_conf_opt) if d["name"] == option["name"])
			option["blacklist"] = False
			option["value"] = parsed_pkg_conf_opt[i]["value"]
		except:
			pass
		option["blacklist"] = blacklist_hit(option["name"], meson_blacklist)
		if option["blacklist"]:
			continue

		value = option["value"]
		if not isinstance(value, str) or value.count(" ") > 0:
			i = io.StringIO()
			json.dump(value, i)
			value = i.getvalue()

		args.append("\t-D%s=%s\n" % (option["name"], value))

	label = os.path.basename(d)
	return (options, args, label)

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

if len(sys.argv) == 1:
	parser.print_help()
	exit(1)

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
pkg_subdir = ""
tool = None
if args.pkg:
	(tool, d, pkg_subdir, pkg_conf_opt) = ask_ptxdist(ptx_PKG)
	ptx_pkg_label = "rules/%s.make" % ptx_pkg
	if tool == "autoconf":
		parsed_pkg_conf_opt = parse_configure_args(pkg_conf_opt, [])
	if tool == "meson":
		(parsed_pkg_conf_opt, pkg_conf_opt) = parse_meson_args(pkg_conf_opt, [])

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

(old_parsed_configure_args, old_pkg_conf_opt, old_pkg_label) = handle_dir(old_dir, pkg_subdir)
(new_parsed_configure_args, new_pkg_conf_opt, new_pkg_label) = handle_dir(new_dir, pkg_subdir)

if not old_pkg_conf_opt:
	show_diff(ptx_pkg_conf_opt, ptx_pkg_label, new_pkg_conf_opt, new_pkg_label)
elif not new_pkg_conf_opt:
	show_diff(old_pkg_conf_opt, old_pkg_label, ptx_pkg_conf_opt, ptx_pkg_label)
else:
	show_diff(old_pkg_conf_opt, old_pkg_label, new_pkg_conf_opt, new_pkg_label)

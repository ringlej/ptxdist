# -*-makefile-*-
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GREP) += grep

#
# Paths and names
#
GREP_VERSION	:= 2.26
GREP_MD5	:= afdd61c7221434722671baf002ac9267
GREP		:= grep-$(GREP_VERSION)
GREP_SUFFIX	:= tar.xz
GREP_URL	:= $(call ptx/mirror, GNU, grep/$(GREP).$(GREP_SUFFIX))
GREP_SOURCE	:= $(SRCDIR)/$(GREP).$(GREP_SUFFIX)
GREP_DIR	:= $(BUILDDIR)/$(GREP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GREP_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_GMSGFMT=: \
	ac_cv_path_XGETTEXT=:

#
# autoconf
#
GREP_CONF_TOOL	:= autoconf
GREP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-assert \
	--disable-rpath \
	--disable-nls \
	--$(call ptx/endis, PTXCONF_GREP_PCRE)-perl-regexp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/grep.targetinstall:
	@$(call targetinfo)

	@$(call install_init, grep)
	@$(call install_fixup, grep,PRIORITY,optional)
	@$(call install_fixup, grep,SECTION,base)
	@$(call install_fixup, grep,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, grep,DESCRIPTION,missing)

	@$(call install_copy, grep, 0, 0, 0755, -, /usr/bin/grep)

	@$(call install_finish, grep)

	@$(call touch)

# vim: syntax=make

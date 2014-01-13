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
GREP_VERSION	:= 2.16
GREP_MD5	:= 502350a6c8f7c2b12ee58829e760b44d
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
	$(CROSS_AUTOCONF_ROOT) \
	--$(call ptx/endis, PTXCONF_GREP_PCRE)-perl-regexp \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls

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

	@$(call install_copy, grep, 0, 0, 0755, -, /bin/grep)

	@$(call install_finish, grep)

	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PSMISC) += psmisc

#
# Paths and names
#
PSMISC_VERSION	:= 22.20
PSMISC_MD5	:= a25fc99a6dc7fa7ae6e4549be80b401f
PSMISC		:= psmisc-$(PSMISC_VERSION)
PSMISC_SUFFIX	:= tar.gz
PSMISC_URL	:= $(call ptx/mirror, SF, psmisc/$(PSMISC).$(PSMISC_SUFFIX))
PSMISC_SOURCE	:= $(SRCDIR)/$(PSMISC).$(PSMISC_SUFFIX)
PSMISC_DIR	:= $(BUILDDIR)/$(PSMISC)
PSMISC_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PSMISC_CONF_TOOL	:= autoconf
PSMISC_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-selinux \
	--disable-timeout-stat \
	$(GLOBAL_IPV6_OPTION) \
	--disable-nls \
	--disable-rpath \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/psmisc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, psmisc)
	@$(call install_fixup, psmisc,PRIORITY,optional)
	@$(call install_fixup, psmisc,SECTION,base)
	@$(call install_fixup, psmisc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, psmisc,DESCRIPTION,missing)

	@$(call install_copy, psmisc, 0, 0, 0755, -, /usr/bin/fuser)
	@$(call install_copy, psmisc, 0, 0, 0755, -, /usr/bin/killall)
	@$(call install_copy, psmisc, 0, 0, 0755, -, /usr/bin/peekfd)
	@$(call install_copy, psmisc, 0, 0, 0755, -, /usr/bin/prtstat)
	@$(call install_copy, psmisc, 0, 0, 0755, -, /usr/bin/pstree)

	@$(call install_finish, psmisc)

	@$(call touch)

# vim: syntax=make

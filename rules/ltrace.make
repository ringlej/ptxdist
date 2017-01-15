# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_ARM64
PACKAGES-$(PTXCONF_LTRACE) += ltrace
endif

#
# Paths and names
#
LTRACE_VERSION	:= 0.7.3
LTRACE_MD5	:= b3dd199af8f18637f7d4ef97fdfb9d14
LTRACE_SUFFIX	:= orig.tar.bz2
LTRACE		:= ltrace-$(LTRACE_VERSION)
LTRACE_TARBALL	:= ltrace_$(LTRACE_VERSION).$(LTRACE_SUFFIX)
LTRACE_URL	:= http://snapshot.debian.org/archive/debian/20140102T220511Z/pool/main/l/ltrace/$(LTRACE_TARBALL)
LTRACE_SOURCE	:= $(SRCDIR)/$(LTRACE_TARBALL)
LTRACE_DIR	:= $(BUILDDIR)/$(LTRACE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LTRACE_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-werror \
	--disable-valgrind \
	--without-libunwind

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltrace.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  ltrace)
	@$(call install_fixup, ltrace,PRIORITY,optional)
	@$(call install_fixup, ltrace,SECTION,base)
	@$(call install_fixup, ltrace,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, ltrace,DESCRIPTION,missing)

	@$(call install_copy, ltrace, 0, 0, 0755, -, /usr/bin/ltrace)

	@$(call install_finish, ltrace)

	@$(call touch)

# vim: syntax=make

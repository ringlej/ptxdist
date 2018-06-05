# -*-makefile-*-
#
# Copyright (C) 2016 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_ARM)-$(PTXCONF_LATRACE) += latrace
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_LATRACE) += latrace
#
# Paths and names
#
LATRACE_VERSION	:= 0.5.11
LATRACE_MD5	:= 138457c7b9eaf3246eddb7856702cddf
LATRACE		:= latrace-$(LATRACE_VERSION)
LATRACE_SUFFIX	:= tar.bz2
LATRACE_URL	:= http://people.redhat.com/jolsa/latrace/dl/$(LATRACE).$(LATRACE_SUFFIX)
LATRACE_SOURCE	:= $(SRCDIR)/$(LATRACE).$(LATRACE_SUFFIX)
LATRACE_DIR	:= $(BUILDDIR)/$(LATRACE)
LATRACE_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LATRACE_ARCH	:= $(PTXCONF_ARCH_STRING)
ifeq ($(PTXCONF_ARCH_X86)-$(PTXCONF_ARCH_X86_64),y-)
LATRACE_ARCH	:= "i686"
endif

LATRACE_CONF_ENV := \
	$(CROSS_ENV) \
	latrace_arch=$(LATRACE_ARCH) \
	ac_cv_path_ASCIIDOC=: \
	ac_cv_path_XMLTO=:
#
# autoconf
#
LATRACE_CONF_TOOL	:= autoconf
LATRACE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION)

# autotools, but hand-made Makefile m(
LATRACE_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/latrace.targetinstall:
	@$(call targetinfo)

	@$(call install_init, latrace)
	@$(call install_fixup, latrace,PRIORITY,optional)
	@$(call install_fixup, latrace,SECTION,base)
	@$(call install_fixup, latrace,AUTHOR,"Juergen Borleis <jbe@pengutronix.de>")
	@$(call install_fixup, latrace,DESCRIPTION,"library call tracer")

	@$(call install_alternative, latrace, 0, 0, 0644, /etc/latrace.d/latrace.conf)
	@$(call install_tree, latrace, 0, 0, -, /etc/latrace.d/headers/)

	@$(call install_copy, latrace, 0, 0, 0755, -, /usr/bin/latrace)
	@$(call install_link, latrace, latrace, /usr/bin/latrace-ctl)
	@$(call install_lib, latrace, 0, 0, 0644, libltaudit)

	@$(call install_finish, latrace)

	@$(call touch)

# vim: syntax=make

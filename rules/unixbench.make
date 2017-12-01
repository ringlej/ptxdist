# -*-makefile-*-
#
# Copyright (C) 2014 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UNIXBENCH) += unixbench

#
# Paths and names
#
UNIXBENCH_VERSION	:= 5.1.2
UNIXBENCH_MD5		:= 10edef9af6ad29770437d0b39828218d
UNIXBENCH		:= unixbench-$(UNIXBENCH_VERSION)
UNIXBENCH_SUFFIX	:= tar.gz
UNIXBENCH_URL		:= https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/byte-unixbench/$(UNIXBENCH).$(UNIXBENCH_SUFFIX)
UNIXBENCH_SOURCE	:= $(SRCDIR)/$(UNIXBENCH).$(UNIXBENCH_SUFFIX)
UNIXBENCH_DIR		:= $(BUILDDIR)/$(UNIXBENCH)
UNIXBENCH_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UNIXBENCH_MAKE_PAR := NO
UNIXBENCH_MAKE_OPT := $(CROSS_ENV_CC) PREFIX=/usr
UNIXBENCH_INSTALL_OPT := $(UNIXBENCH_MAKE_OPT) install

$(STATEDIR)/unixbench.prepare:
	@$(call targetinfo)
	@$(call disable_sh,$(UNIXBENCH_DIR)/Makefile,GRAPHIC_TESTS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/unixbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, unixbench)
	@$(call install_fixup, unixbench,PRIORITY,optional)
	@$(call install_fixup, unixbench,SECTION,base)
	@$(call install_fixup, unixbench,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, unixbench,DESCRIPTION,missing)

	@$(call install_copy, unixbench, 0, 0, 0755, -, /usr/bin/unixbench)
	@$(call install_copy, unixbench, 0, 0, 0755, /usr/lib/unixbench/results)
	@$(call install_copy, unixbench, 0, 0, 0755, /usr/lib/unixbench/tmp)
	@$(call install_tree, unixbench, 0, 0, -, /usr/lib/unixbench)

	@$(call install_finish, unixbench)

	@$(call touch)

# vim: syntax=make

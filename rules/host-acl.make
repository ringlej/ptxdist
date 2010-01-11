# -*-makefile-*-
#
# Copyright (C) 2009 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ACL) += host-acl

#
# Paths and names
#
HOST_ACL_DIR	= $(HOST_BUILDDIR)/$(ACL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-acl.get: $(STATEDIR)/acl.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-acl.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_ACL_DIR))
	@$(call extract, ACL, $(HOST_BUILDDIR))
	@$(call patchin, ACL, $(HOST_ACL_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ACL_ENV := $(HOST_ENV)

HOST_ACL_INSTALL_OPT := \
	install \
	install-lib \
	install-dev

HOST_ACL_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--libexecdir=$(PTXDIST_SYSROOT_HOST)/lib \
	--enable-shared

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-acl_clean:
	rm -rf $(STATEDIR)/host-acl.*
	rm -rf $(HOST_ACL_DIR)

# vim: syntax=make

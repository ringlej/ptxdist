# -*-makefile-*-
#
# Copyright (C) 2009 by Carsten Schlote <c.schlote@konzeptpark.de>
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

HOST_ACL_PATH	:= PATH=$(HOST_PATH)
HOST_ACL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_ACL_AUTOCONF := $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-acl_clean:
	rm -rf $(STATEDIR)/host-acl.*
	rm -rf $(HOST_ACL_DIR)

# vim: syntax=make

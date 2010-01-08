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
HOST_PACKAGES-$(PTXCONF_HOST_ATTR) += host-attr

#
# Paths and names
#
HOST_ATTR_DIR	= $(HOST_BUILDDIR)/$(ATTR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-attr.get: $(STATEDIR)/attr.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-attr.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_ATTR_DIR))
	@$(call extract, ATTR, $(HOST_BUILDDIR))
	@$(call patchin, ATTR, $(HOST_ATTR_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ATTR_PATH	:= PATH=$(HOST_PATH)
HOST_ATTR_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_ATTR_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-attr_clean:
	rm -rf $(STATEDIR)/host-attr.*
	rm -rf $(HOST_ATTR_DIR)

# vim: syntax=make

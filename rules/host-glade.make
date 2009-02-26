# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLADE) += host-glade

ifdef PTXCONF_HOST_GLADE
ifeq ($(shell perl -e "require XML::Parser" 2>/dev/null || echo no),no)
    $(warning *** XML::Parser perl module is required for host-glade)
    $(warning *** please install libxml-parser-perl (debian))
    $(error )
endif
endif

#
# Paths and names
#
HOST_GLADE_DIR	= $(HOST_BUILDDIR)/$(GLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glade.get: $(STATEDIR)/glade.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-glade.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_GLADE_DIR))
	@$(call extract, GLADE, $(HOST_BUILDDIR))
	@$(call patchin, GLADE, $(HOST_GLADE_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLADE_PATH	:= PATH=$(HOST_PATH)
HOST_GLADE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLADE_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-glade_clean:
	rm -rf $(STATEDIR)/host-glade.*
	rm -rf $(HOST_GLADE_DIR)

# vim: syntax=make

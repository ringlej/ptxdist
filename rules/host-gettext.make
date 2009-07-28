# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GETTEXT) += host-gettext

#
# Paths and names
#
HOST_GETTEXT_DIR	= $(HOST_BUILDDIR)/$(GETTEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gettext.get: $(STATEDIR)/gettext.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------


$(STATEDIR)/host-gettext.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_GETTEXT_DIR))
	@$(call extract, GETTEXT, $(HOST_BUILDDIR))
	@$(call patchin, GETTEXT, $(HOST_GETTEXT_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GETTEXT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GETTEXT_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-java \
	--disable-native-java \
	--disable-csharp

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gettext_clean:
	rm -rf $(STATEDIR)/host-gettext.*
	rm -rf $(HOST_GETTEXT_DIR)

# vim: syntax=make

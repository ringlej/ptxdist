# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DASH) += dash

#
# Paths and names
#
DASH_VERSION	:= 0.5.4
DASH		:= dash-$(DASH_VERSION)
DASH_SUFFIX	:= tar.gz
DASH_URL	:= http://gondor.apana.org.au/~herbert/dash/files/$(DASH).$(DASH_SUFFIX)
DASH_SOURCE	:= $(SRCDIR)/$(DASH).$(DASH_SUFFIX)
DASH_DIR	:= $(BUILDDIR)/$(DASH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/dash.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DASH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DASH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/dash.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(DASH_DIR))
	@$(call extract, DASH)
	@$(call patchin, DASH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DASH_PATH	:= PATH=$(CROSS_PATH)
DASH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DASH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-libedit=no

$(STATEDIR)/dash.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(DASH_DIR)/config.cache)
	cd $(DASH_DIR) && \
		$(DASH_PATH) $(DASH_ENV) \
		./configure $(DASH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/dash.compile:
	@$(call targetinfo, $@)
	cd $(DASH_DIR) && $(DASH_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dash.install:
	@$(call targetinfo, $@)
	@$(call install, DASH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dash.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init,  dash)
	@$(call install_fixup, dash,PACKAGE,dash)
	@$(call install_fixup, dash,PRIORITY,optional)
	@$(call install_fixup, dash,VERSION,$(DASH_VERSION))
	@$(call install_fixup, dash,SECTION,base)
	@$(call install_fixup, dash,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, dash,DEPENDS,)
	@$(call install_fixup, dash,DESCRIPTION,missing)

	@$(call install_copy, dash, 0, 0, 0755, $(DASH_DIR)/src/dash, /bin/dash)

	@$(call install_finish, dash)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dash_clean:
	rm -rf $(STATEDIR)/dash.*
	rm -rf $(IMAGEDIR)/dash_*
	rm -rf $(DASH_DIR)

# vim: syntax=make

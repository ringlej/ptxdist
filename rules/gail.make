# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GAIL) += gail

#
# Paths and names
#
GAIL_VERSION	= 1.5.5
GAIL		= gail-$(GAIL_VERSION)
GAIL_SUFFIX	= tar.bz2
GAIL_URL	= ftp://ftp.gnome.org/pub/GNOME/sources/gail/1.5/$(GAIL).$(GAIL_SUFFIX)
GAIL_SOURCE	= $(SRCDIR)/$(GAIL).$(GAIL_SUFFIX)
GAIL_DIR	= $(BUILDDIR)/$(GAIL)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gail_get: $(STATEDIR)/gail.get

$(STATEDIR)/gail.get: $(gail_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GAIL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GAIL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gail_extract: $(STATEDIR)/gail.extract

$(STATEDIR)/gail.extract: $(gail_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GAIL_DIR))
	@$(call extract, $(GAIL_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gail_prepare: $(STATEDIR)/gail.prepare

GAIL_PATH	=  PATH=$(CROSS_PATH)
GAIL_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
GAIL_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/gail.prepare: $(gail_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GAIL_DIR)/config.cache)
	cd $(GAIL_DIR) && \
		$(GAIL_PATH) $(GAIL_ENV) \
		./configure $(GAIL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gail_compile: $(STATEDIR)/gail.compile

$(STATEDIR)/gail.compile: $(gail_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GAIL_DIR) && \
	$(GAIL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gail_install: $(STATEDIR)/gail.install

$(STATEDIR)/gail.install: $(gail_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GAIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gail_targetinstall: $(STATEDIR)/gail.targetinstall

$(STATEDIR)/gail.targetinstall: $(gail_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gail)
	@$(call install_fixup, gail,PACKAGE,gail)
	@$(call install_fixup, gail,PRIORITY,optional)
	@$(call install_fixup, gail,VERSION,$(GAIL_VERSION))
	@$(call install_fixup, gail,SECTION,base)
	@$(call install_fixup, gail,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gail,DEPENDS,)
	@$(call install_fixup, gail,DESCRIPTION,missing)

	@$(call install_copy, gail, 0, 0, 0644, $(GAIL_DIR)/gail/.libs/libgail.so, /usr/lib/libgail.so)
	@$(call install_copy, gail, 0, 0, 0644, $(GAIL_DIR)/libgail-util/.libs/libgailutil.so.17.0.0, /usr/lib/libgailutil.so.17.0.0)
	@$(call install_link, gail, libgailutil.so.17.0.0, /usr/lib/libgailutil.so.17.0)
	@$(call install_link, gail, libgailutil.so.17.0.0, /usr/lib/libgailutil.so.17)
	@$(call install_link, gail, libgailutil.so.17.0.0, /usr/lib/libgailutil.so)

	@$(call install_finish, gail)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gail_clean:
	rm -rf $(STATEDIR)/gail.*
	rm -rf $(IMAGEDIR)/gail_*
	rm -rf $(GAIL_DIR)

# vim: syntax=make

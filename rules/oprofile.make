# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
# Copyright (C) 2003      by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003-2007 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPROFILE) += oprofile

#
# Paths and names
#
OPROFILE_VERSION	:= 0.9.3
OPROFILE		:= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		:= tar.gz
OPROFILE_URL		:= $(PTXCONF_SETUP_SFMIRROR)/oprofile/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_SOURCE		:= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		:= $(BUILDDIR)/$(OPROFILE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

oprofile_get: $(STATEDIR)/oprofile.get

$(STATEDIR)/oprofile.get: $(oprofile_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPROFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OPROFILE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

oprofile_extract: $(STATEDIR)/oprofile.extract

$(STATEDIR)/oprofile.extract: $(oprofile_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR))
	@$(call extract, OPROFILE)
	@$(call patchin, OPROFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

oprofile_prepare: $(STATEDIR)/oprofile.prepare

OPROFILE_PATH	:= PATH=$(CROSS_PATH)
OPROFILE_ENV 	:= $(CROSS_ENV)

ifndef PTXCONF_OPROFILE_SHARED
OPROFILE_ENV	+=  LDFLAGS="-L$(SYSROOT)/usr/lib -static"
else
OPROFILE_ENV	+=  LDFLAGS="-L$(SYSROOT)/usr/lib"
endif

#
# autoconf
#
OPROFILE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-sanity-checks \
	--with-linux=$(KERNEL_DIR)

$(STATEDIR)/oprofile.prepare: $(oprofile_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR)/config.cache)
	cd $(OPROFILE_DIR) && \
		$(OPROFILE_PATH) $(OPROFILE_ENV) \
		./configure $(OPROFILE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

oprofile_compile: $(STATEDIR)/oprofile.compile

$(STATEDIR)/oprofile.compile: $(oprofile_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(OPROFILE_DIR) && $(OPROFILE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

oprofile_install: $(STATEDIR)/oprofile.install

$(STATEDIR)/oprofile.install: $(oprofile_install_deps_default)
	@$(call targetinfo, $@)
#	@$(call install, OPROFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

oprofile_targetinstall: $(STATEDIR)/oprofile.targetinstall

$(STATEDIR)/oprofile.targetinstall: $(oprofile_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, oprofile)
	@$(call install_fixup, oprofile,PACKAGE,oprofile)
	@$(call install_fixup, oprofile,PRIORITY,optional)
	@$(call install_fixup, oprofile,VERSION,$(OPROFILE_VERSION))
	@$(call install_fixup, oprofile,SECTION,base)
	@$(call install_fixup, oprofile,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, oprofile,DEPENDS,)
	@$(call install_fixup, oprofile,DESCRIPTION,missing)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/utils/opcontrol, \
		/usr/bin/opcontrol, 0 \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/utils/ophelp, \
		/usr/bin/ophelp \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/pp/opreport, \
		/usr/bin/opreport \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/daemon/oprofiled, \
		/usr/bin/oprofiled \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/events/arm/xscale2/events, \
		/usr/share/oprofile/arm/xscale2/events, 0 \
	)

	@$(call install_copy, oprofile, 0, 0, 0755, \
		$(OPROFILE_DIR)/events/arm/xscale2/unit_masks, \
		/usr/share/oprofile/arm/xscale2/unit_masks, 0 \
	)

	@$(call install_finish, oprofile)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

oprofile_clean:
	rm -rf $(STATEDIR)/oprofile.*
	rm -rf $(IMAGEDIR)/oprofile_*
	rm -rf $(OPROFILE_DIR)

# vim: syntax=make

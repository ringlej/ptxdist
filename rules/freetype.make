# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREETYPE) += freetype

#
# Paths and names
#
FREETYPE_VERSION	:= 2.3.4
FREETYPE		:= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		:= tar.bz2
FREETYPE_URL		:= http://download.savannah.gnu.org/releases/freetype/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_SOURCE		:= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		:= $(BUILDDIR)/$(FREETYPE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

freetype_get: $(STATEDIR)/freetype.get

$(STATEDIR)/freetype.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FREETYPE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FREETYPE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

freetype_extract: $(STATEDIR)/freetype.extract

$(STATEDIR)/freetype.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(FREETYPE_DIR))
	@$(call extract, FREETYPE)
	@$(call patchin, FREETYPE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

freetype_prepare: $(STATEDIR)/freetype.prepare

FREETYPE_PATH	:= PATH=$(CROSS_PATH)
FREETYPE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FREETYPE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/freetype.prepare:
	@$(call targetinfo, $@)
	cd $(FREETYPE_DIR) && \
		$(FREETYPE_PATH) $(FREETYPE_ENV) \
		./configure $(FREETYPE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

freetype_compile: $(STATEDIR)/freetype.compile

$(STATEDIR)/freetype.compile:
	@$(call targetinfo, $@)
	cd $(FREETYPE_DIR) && \
		$(FREETYPE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

freetype_install: $(STATEDIR)/freetype.install

$(STATEDIR)/freetype.install:
	@$(call targetinfo, $@)
	@$(call install, FREETYPE)
	$(INSTALL) -m 755 -D $(FREETYPE_DIR)/builds/unix/freetype-config \
		$(PTXCONF_SYSROOT_CROSS)/bin/freetype-config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

freetype_targetinstall: $(STATEDIR)/freetype.targetinstall

$(STATEDIR)/freetype.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, freetype)
	@$(call install_fixup, freetype,PACKAGE,freetype)
	@$(call install_fixup, freetype,PRIORITY,optional)
	@$(call install_fixup, freetype,VERSION,$(FREETYPE_VERSION))
	@$(call install_fixup, freetype,SECTION,base)
	@$(call install_fixup, freetype,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, freetype,DEPENDS,)
	@$(call install_fixup, freetype,DESCRIPTION,missing)

	@$(call install_copy, freetype, 0, 0, 0644, \
		$(FREETYPE_DIR)/objs/.libs/libfreetype.so.6.3.15, \
		/usr/lib/libfreetype.so.6.3.15)
	@$(call install_link, freetype, libfreetype.so.6.3.15, /usr/lib/libfreetype.so.6)
	@$(call install_link, freetype, libfreetype.so.6.3.15, /usr/lib/libfreetype.so)

	@$(call install_finish, freetype)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

freetype_clean:
	rm -rf $(STATEDIR)/freetype.*
	rm -rf $(IMAGEDIR)/freetype_*
	rm -rf $(FREETYPE_DIR)

# vim: syntax=make

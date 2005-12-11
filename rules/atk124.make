# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATK) += atk

#
# Paths and names
#
ATK_VERSION	= 1.5.4
ATK		= atk-$(ATK_VERSION)
ATK_SUFFIX	= tar.gz
ATK_URL		= ftp://ftp.gnome.org/pub/GNOME/sources/atk/1.5/$(ATK).$(ATK_SUFFIX)
ATK_SOURCE	= $(SRCDIR)/$(ATK).$(ATK_SUFFIX)
ATK_DIR		= $(BUILDDIR)/$(ATK)
ATK_LIB_VERSION	= 501.3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

atk_get: $(STATEDIR)/atk.get

atk_get_deps	=  $(ATK_SOURCE)

$(STATEDIR)/atk.get: $(atk_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ATK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ATK_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

atk_extract: $(STATEDIR)/atk.extract

atk_extract_deps	=  $(STATEDIR)/atk.get

$(STATEDIR)/atk.extract: $(atk_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_DIR))
	@$(call extract, $(ATK_SOURCE))
	@$(call patchin, $(ATK))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

atk_prepare: $(STATEDIR)/atk.prepare

#
# dependencies
#
atk_prepare_deps =  \
	$(STATEDIR)/atk.extract \
	$(STATEDIR)/pango12.install \
	$(STATEDIR)/virtual-xchain.install

ATK_PATH	=  PATH=$(CROSS_PATH)
ATK_ENV 	=  $(CROSS_ENV)
ATK_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
ATK_AUTOCONF	= $(CROSS_AUTOCONF)
ATK_AUTOCONF	+= --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/atk.prepare: $(atk_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_BUILDDIR))
	cd $(ATK_DIR) && \
		$(ATK_PATH) $(ATK_ENV) \
		./configure $(ATK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

atk_compile: $(STATEDIR)/atk.compile

atk_compile_deps =  $(STATEDIR)/atk.prepare

$(STATEDIR)/atk.compile: $(atk_compile_deps)
	@$(call targetinfo, $@)
	$(ATK_PATH) make -C $(ATK_DIR) 
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

atk_install: $(STATEDIR)/atk.install

$(STATEDIR)/atk.install: $(STATEDIR)/atk.compile
	@$(call targetinfo, $@)
	@$(call install, ATK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

atk_targetinstall: $(STATEDIR)/atk.targetinstall

atk_targetinstall_deps	=  $(STATEDIR)/atk.compile

$(STATEDIR)/atk.targetinstall: $(atk_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,atk)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(ATK_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(ATK_DIR)/atk/.libs/libatk-1.0.so.0.$(ATK_LIB_VERSION), \
		/usr/lib/libatk-1.0.so.o.$(ATK_LIB_VERSION))
	@$(call install_link, libatk-1.0.so.0.$(ATK_LIB_VERSION), /usr/lib/libatk-1.0.so.0)
	@$(call install_link, libatk-1.0.so.0.$(ATK_LIB_VERSION), /usr/lib/libatk-1.0.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

atk_clean:
	rm -rf $(STATEDIR)/atk.*
	rm -rf $(IMAGEDIR)/atk_*
	rm -rf $(ATK_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/atk*.pc

# vim: syntax=make

# -*-makefile-*-
# $Id: atk124.make,v 1.6 2004/02/24 09:58:38 robert Exp $
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
ifdef PTXCONF_ATK
PACKAGES += atk
endif

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
	touch $@

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
	touch $@

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
ATK_ENV	+= PKG_CONFIG_PATH=../$(GLIB22):../$(ATK):../$(PANGO12):../$(GTK22)

#
# autoconf
#
ATK_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
ATK_AUTOCONF	+= --build=$(GNU_HOST)
ATK_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

ifdef PTXCONF_ATK_FOO
ATK_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/atk.prepare: $(atk_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_BUILDDIR))
	cd $(ATK_DIR) && \
		$(ATK_PATH) $(ATK_ENV) \
		./configure $(ATK_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

atk_compile: $(STATEDIR)/atk.compile

atk_compile_deps =  $(STATEDIR)/atk.prepare

$(STATEDIR)/atk.compile: $(atk_compile_deps)
	@$(call targetinfo, $@)
	$(ATK_PATH) make -C $(ATK_DIR) 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

atk_install: $(STATEDIR)/atk.install

$(STATEDIR)/atk.install: $(STATEDIR)/atk.compile
	@$(call targetinfo, $@)
	$(ATK_PATH) make -C $(ATK_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

atk_targetinstall: $(STATEDIR)/atk.targetinstall

atk_targetinstall_deps	=  $(STATEDIR)/atk.compile

$(STATEDIR)/atk.targetinstall: $(atk_targetinstall_deps)
	@$(call targetinfo, $@)

	install -d $(ROOTDIR)
	rm -f $(ROOTDIR)/lib/libatk-1.0.so*
	install $(ATK_DIR)/atk/.libs/libatk-1.0.so.0.$(ATK_LIB_VERSION) $(ROOTDIR)/lib/
	ln -s libatk-1.0.so.0.$(ATK_LIB_VERSION) $(ROOTDIR)/lib/libatk-1.0.so.0
	ln -s libatk-1.0.so.0.$(ATK_LIB_VERSION) $(ROOTDIR)/lib/libatk-1.0.so

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

atk_clean:
	rm -rf $(STATEDIR)/atk.*
	rm -rf $(ATK_DIR)
	rm -f $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/share/pkg-config/atk*.pc

# vim: syntax=make

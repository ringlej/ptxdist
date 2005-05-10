# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_WGET
PACKAGES += wget
endif

#
# Paths and names
#
WGET_VERSION	= 1.9.1
WGET_PACKET	= wget-$(WGET_VERSION)
WGET_SUFFIX	= tar.gz
WGET_URL	= $(PTXCONF_SETUP_GNUMIRROR)/wget/$(WGET_PACKET).$(WGET_SUFFIX)
WGET_SOURCE	= $(SRCDIR)/$(WGET_PACKET).$(WGET_SUFFIX)
WGET_DIR	= $(BUILDDIR)/$(WGET_PACKET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wget_get: $(STATEDIR)/wget.get

wget_get_deps = $(WGET_SOURCE)

$(STATEDIR)/wget.get: $(wget_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(WGET_PACKET))
	touch $@

$(WGET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(WGET_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wget_extract: $(STATEDIR)/wget.extract

wget_extract_deps = $(STATEDIR)/wget.get

$(STATEDIR)/wget.extract: $(wget_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(WGET_DIR))
	@$(call extract, $(WGET_SOURCE))
	@$(call patchin, $(WGET_PACKET))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wget_prepare: $(STATEDIR)/wget.prepare

#
# dependencies
#
wget_prepare_deps = \
	$(STATEDIR)/wget.extract \
	$(STATEDIR)/virtual-xchain.install

WGET_PATH	=  PATH=$(CROSS_PATH)
WGET_ENV 	=  $(CROSS_ENV)
#WGET_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#WGET_ENV	+=

#
# autoconf
#
WGET_AUTOCONF =  $(CROSS_AUTOCONF)
WGET_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
WGET_AUTOCONF += --without-socks
WGET_AUTOCONF += --without-ssl

$(STATEDIR)/wget.prepare: $(wget_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(WGET_DIR)/config.cache)
	cd $(WGET_DIR) && \
		$(WGET_PATH) $(WGET_ENV) \
		./configure $(WGET_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wget_compile: $(STATEDIR)/wget.compile

wget_compile_deps = $(STATEDIR)/wget.prepare

$(STATEDIR)/wget.compile: $(wget_compile_deps)
	@$(call targetinfo, $@)
	cd $(WGET_DIR) && $(WGET_ENV) $(WGET_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wget_install: $(STATEDIR)/wget.install

$(STATEDIR)/wget.install: $(STATEDIR)/wget.compile
	@$(call targetinfo, $@)
	cd $(WGET_DIR) && $(WGET_ENV) $(WGET_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wget_targetinstall: $(STATEDIR)/wget.targetinstall

wget_targetinstall_deps = $(STATEDIR)/wget.compile

$(STATEDIR)/wget.targetinstall: $(wget_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,wget)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(WGET_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(WGET_DIR)/src/wget, /usr/bin/wget)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wget_clean:
	rm -rf $(STATEDIR)/wget.*
	rm -rf $(IMAGEDIR)/wget_*
	rm -rf $(WGET_DIR)

# vim: syntax=make

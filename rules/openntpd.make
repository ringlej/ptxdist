# $Id: template 2680 2005-05-27 10:29:43Z rsc $
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
ifdef PTXCONF_OPENNTPD
PACKAGES += openntpd
endif

#
# Paths and names
#
OPENNTPD_VERSION	= 3.7p1
OPENNTPD		= openntpd-$(OPENNTPD_VERSION)
OPENNTPD_SUFFIX		= tar.gz
OPENNTPD_URL		= ftp://ftp.de.openbsd.org/pub/unix/OpenBSD/OpenNTPD/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_SOURCE		= $(SRCDIR)/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_DIR		= $(BUILDDIR)/$(OPENNTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openntpd_get: $(STATEDIR)/openntpd.get

openntpd_get_deps = $(OPENNTPD_SOURCE)

$(STATEDIR)/openntpd.get: $(openntpd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(OPENNTPD))
	touch $@

$(OPENNTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(OPENNTPD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openntpd_extract: $(STATEDIR)/openntpd.extract

openntpd_extract_deps = $(STATEDIR)/openntpd.get

$(STATEDIR)/openntpd.extract: $(openntpd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENNTPD_DIR))
	@$(call extract, $(OPENNTPD_SOURCE))
	@$(call patchin, $(OPENNTPD))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openntpd_prepare: $(STATEDIR)/openntpd.prepare

#
# dependencies
#
openntpd_prepare_deps = \
	$(STATEDIR)/openntpd.extract \
	$(STATEDIR)/virtual-xchain.install

OPENNTPD_PATH	=  PATH=$(CROSS_PATH)
OPENNTPD_ENV 	=  $(CROSS_ENV)
#OPENNTPD_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#OPENNTPD_ENV	+=

#
# autoconf
#
OPENNTPD_AUTOCONF =  $(CROSS_AUTOCONF)
OPENNTPD_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

ifdef PTXCONF_OPENNTPD_ARC4RANDOM
OPENNTPD_AUTOCONF += --with-builtin-arc4random
else
OPENNTPD_AUTOCONF += --without-builtin-arc4random
endif

$(STATEDIR)/openntpd.prepare: $(openntpd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENNTPD_DIR)/config.cache)
	cd $(OPENNTPD_DIR) && \
		$(OPENNTPD_PATH) $(OPENNTPD_ENV) \
		./configure $(OPENNTPD_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openntpd_compile: $(STATEDIR)/openntpd.compile

openntpd_compile_deps = $(STATEDIR)/openntpd.prepare

$(STATEDIR)/openntpd.compile: $(openntpd_compile_deps)
	@$(call targetinfo, $@)
	cd $(OPENNTPD_DIR) && $(OPENNTPD_ENV) $(OPENNTPD_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openntpd_install: $(STATEDIR)/openntpd.install

$(STATEDIR)/openntpd.install: $(STATEDIR)/openntpd.compile
	@$(call targetinfo, $@)
	cd $(OPENNTPD_DIR) && $(OPENNTPD_ENV) $(OPENNTPD_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openntpd_targetinstall: $(STATEDIR)/openntpd.targetinstall

openntpd_targetinstall_deps = $(STATEDIR)/openntpd.compile

$(STATEDIR)/openntpd.targetinstall: $(openntpd_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,openntpd)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(OPENNTPD_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(COREUTILS_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openntpd_clean:
	rm -rf $(STATEDIR)/openntpd.*
	rm -rf $(IMAGEDIR)/openntpd_*
	rm -rf $(OPENNTPD_DIR)

# vim: syntax=make

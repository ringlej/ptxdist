#
# $Id:$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PCRE
PACKAGES += pcre
endif

#
# Paths and names
#
PCRE_VERSION		= 5.0
PCRE			= pcre-$(PCRE_VERSION)
PCRE_SUFFIX		= tar.gz
PCRE_URL		= ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$(PCRE).$(PCRE_SUFFIX)
PCRE_SOURCE		= $(SRCDIR)/$(PCRE).$(PCRE_SUFFIX)
PCRE_DIR		= $(BUILDDIR)/$(PCRE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pcre_get: $(STATEDIR)/pcre.get

pcre_get_deps = $(PCRE_SOURCE)

$(STATEDIR)/pcre.get: $(pcre_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PCRE))
	touch $@

$(PCRE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PCRE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pcre_extract: $(STATEDIR)/pcre.extract

pcre_extract_deps = $(STATEDIR)/pcre.get

$(STATEDIR)/pcre.extract: $(pcre_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PCRE_DIR))
	@$(call extract, $(PCRE_SOURCE))
	@$(call patchin, $(PCRE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pcre_prepare: $(STATEDIR)/pcre.prepare

#
# dependencies
#
pcre_prepare_deps = \
	$(STATEDIR)/pcre.extract \
	$(STATEDIR)/virtual-xchain.install

PCRE_PATH	=  PATH=$(CROSS_PATH)
PCRE_ENV 	=  $(CROSS_ENV)
#PCRE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#PCRE_ENV	+=

#
# autoconf
#
PCRE_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/pcre.prepare: $(pcre_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PCRE_DIR)/config.cache)
	cd $(PCRE_DIR) && \
		$(PCRE_PATH) $(PCRE_ENV) \
		./configure $(PCRE_AUTOCONF)

	# Hack: libtool wants --tag=C when linking host side tools
	perl -i -p -e 's/LINK_FOR_BUILD = \$$\(LIBTOOL\)/LINK_FOR_BUILD = \$$\(LIBTOOL\) --tag=C/g' $(PCRE_DIR)/Makefile	

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pcre_compile: $(STATEDIR)/pcre.compile

pcre_compile_deps = $(STATEDIR)/pcre.prepare

$(STATEDIR)/pcre.compile: $(pcre_compile_deps)
	@$(call targetinfo, $@)
	cd $(PCRE_DIR) && $(PCRE_ENV) $(PCRE_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pcre_install: $(STATEDIR)/pcre.install

$(STATEDIR)/pcre.install: $(STATEDIR)/pcre.compile
	@$(call targetinfo, $@)
	cd $(PCRE_DIR) && $(PCRE_ENV) $(PCRE_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pcre_targetinstall: $(STATEDIR)/pcre.targetinstall

pcre_targetinstall_deps = $(STATEDIR)/pcre.compile

$(STATEDIR)/pcre.targetinstall: $(pcre_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,pcre)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PCRE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(PCRE_DIR)/.libs/libpcre.so.0.0.1, /usr/lib/libpcre.so.0.0.1)
	@$(call install_link, /usr/lib/libpcre.so.0.0.1, /usr/lib/libpcre.so.0) 
	@$(call install_link, /usr/lib/libpcre.so.0.0.1, /usr/lib/libpcre.so) 
	@$(call install_copy, 0, 0, 0644, $(PCRE_DIR)/.libs/libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so.0.0.0)
	@$(call install_link, /usr/lib/libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so.0) 
	@$(call install_link, /usr/lib/libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so) 

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pcre_clean:
	rm -rf $(STATEDIR)/pcre.*
	rm -rf $(IMAGEDIR)/pcre_*
	rm -rf $(PCRE_DIR)

# vim: syntax=make

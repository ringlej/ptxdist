# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_INETUTILS
PACKAGES += inetutils
endif

#
# Paths and names
#
INETUTILS_VERSION	= 1.4.2
INETUTILS		= inetutils-$(INETUTILS_VERSION)
INETUTILS_SUFFIX	= tar.gz
INETUTILS_URL		= ftp://ftp.gnu.org/gnu/inetutils/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_SOURCE	= $(SRCDIR)/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_DIR		= $(BUILDDIR)/$(INETUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

inetutils_get: $(STATEDIR)/inetutils.get

inetutils_get_deps	=  $(INETUTILS_SOURCE)

$(STATEDIR)/inetutils.get: $(inetutils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(INETUTILS))
	touch $@

$(INETUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(INETUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

inetutils_extract: $(STATEDIR)/inetutils.extract

inetutils_extract_deps	=  $(STATEDIR)/inetutils.get

$(STATEDIR)/inetutils.extract: $(inetutils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(INETUTILS_DIR))
	@$(call extract, $(INETUTILS_SOURCE))
	@$(call patchin, $(INETUTILS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

inetutils_prepare: $(STATEDIR)/inetutils.prepare

#
# dependencies
#
inetutils_prepare_deps =  \
	$(STATEDIR)/inetutils.extract \
	$(STATEDIR)/virtual-xchain.install

INETUTILS_PATH	=  PATH=$(CROSS_PATH)
INETUTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
INETUTILS_AUTOCONF =  $(CROSS_AUTOCONF)
INETUTILS_AUTOCONF += --prefix=/usr \
	--with-PATH-CP=/bin/cp \
	--localstatedir=/var \
	--sysconfdir=/etc

$(STATEDIR)/inetutils.prepare: $(inetutils_prepare_deps)
	@$(call targetinfo, $@)
	cd $(INETUTILS_DIR) && \
		$(INETUTILS_PATH) $(INETUTILS_ENV) \
		./configure $(INETUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

inetutils_compile: $(STATEDIR)/inetutils.compile

inetutils_compile_deps =  $(STATEDIR)/inetutils.prepare

$(STATEDIR)/inetutils.compile: $(inetutils_compile_deps)
	@$(call targetinfo, $@)
	$(INETUTILS_PATH) make -C $(INETUTILS_DIR)/libinetutils

# First the libraries: 
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/libicmp && $(INETUTILS_PATH) make
endif

# Now the tools: 
ifdef PTXCONF_INETUTILS_RCP
	cd $(INETUTILS_DIR)/rcp && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	cd $(INETUTILS_DIR)/rlogind && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RSHD
	cd $(INETUTILS_DIR)/rshd && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/ping && $(INETUTILS_PATH) make
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

inetutils_install: $(STATEDIR)/inetutils.install

$(STATEDIR)/inetutils.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

inetutils_targetinstall: $(STATEDIR)/inetutils.targetinstall

inetutils_targetinstall_deps	=  $(STATEDIR)/inetutils.compile

$(STATEDIR)/inetutils.targetinstall: $(inetutils_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/bin
	install -d $(ROOTDIR)/usr/sbin
ifdef PTXCONF_INETUTILS_RCP
	install -D $(INETUTILS_DIR)/rcp/rcp  $(ROOTDIR)/usr/bin/rcp
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/rcp
endif

ifdef PTXCONF_INETUTILS_RLOGIND
	install -D $(INETUTILS_DIR)/rlogind/rlogind  $(ROOTDIR)/usr/sbin/rlogind
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/rlogind
endif

ifdef PTXCONF_INETUTILS_RSHD
	install -D $(INETUTILS_DIR)/rshd/rshd $(ROOTDIR)/usr/bin/rshd
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/rshd
endif

ifdef PTXCONF_INETUTILS_PING
	install -D $(INETUTILS_DIR)/ping/ping $(ROOTDIR)/bin/ping
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/bin/ping
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inetutils_clean:
	rm -rf $(STATEDIR)/inetutils.*
	rm -rf $(INETUTILS_DIR)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_INETUTILS) += inetutils

#
# Paths and names
#
INETUTILS_VERSION	= 1.4.2
INETUTILS		= inetutils-$(INETUTILS_VERSION)
INETUTILS_SUFFIX	= tar.gz
INETUTILS_URL		= $(PTXCONF_SETUP_GNUMIRROR)/inetutils/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_SOURCE	= $(SRCDIR)/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_DIR		= $(BUILDDIR)/$(INETUTILS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

inetutils_get: $(STATEDIR)/inetutils.get

inetutils_get_deps	=  $(INETUTILS_SOURCE)

$(STATEDIR)/inetutils.get: $(inetutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(INETUTILS))
	@$(call touch, $@)

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
	@$(call touch, $@)

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
INETUTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR)
INETUTILS_AUTOCONF += \
	--with-PATH-CP=/bin/cp \
	--localstatedir=/var \
	--sysconfdir=/etc

$(STATEDIR)/inetutils.prepare: $(inetutils_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(INETUTILS_DIR) && \
		$(INETUTILS_PATH) $(INETUTILS_ENV) \
		./configure $(INETUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

inetutils_compile: $(STATEDIR)/inetutils.compile

inetutils_compile_deps =  $(STATEDIR)/inetutils.prepare

$(STATEDIR)/inetutils.compile: $(inetutils_compile_deps_default)
	@$(call targetinfo, $@)
	$(INETUTILS_PATH) make -C $(INETUTILS_DIR)/libinetutils

# First the libraries: 
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/libicmp && $(INETUTILS_PATH) make
endif

# Now the tools: 
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/ping && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RCP
	cd $(INETUTILS_DIR)/rcp && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	cd $(INETUTILS_DIR)/rlogind && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RSHD
	cd $(INETUTILS_DIR)/rshd && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	cd $(INETUTILS_DIR)/syslogd && $(INETUTILS_PATH) make
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

inetutils_install: $(STATEDIR)/inetutils.install

$(STATEDIR)/inetutils.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

inetutils_targetinstall: $(STATEDIR)/inetutils.targetinstall

inetutils_targetinstall_deps	=  $(STATEDIR)/inetutils.compile

$(STATEDIR)/inetutils.targetinstall: $(inetutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,inetutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(INETUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_INETUTILS_PING
	@$(call install_copy, 0, 0, 0755, $(INETUTILS_DIR)/ping/ping, /bin/ping)
endif
ifdef PTXCONF_INETUTILS_RCP
	@$(call install_copy, 0, 0, 0755, $(INETUTILS_DIR)/rcp/rcp, /usr/bin/rcp)
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	@$(call install_copy, 0, 0, 0755, $(INETUTILS_DIR)/rlogind/rlogind, /usr/sbin/rlogind)
endif
ifdef PTXCONF_INETUTILS_RSHD
	@$(call install_copy, 0, 0, 0755, $(INETUTILS_DIR)/rshd/rshd, /usr/bin/rshd)
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	@$(call install_copy, 0, 0, 0755, $(INETUTILS_DIR)/syslogd/syslogd, /sbin/syslogd)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inetutils_clean:
	rm -rf $(STATEDIR)/inetutils.*
	rm -rf $(IMAGEDIR)/inetutils_*
	rm -rf $(INETUTILS_DIR)

# vim: syntax=make

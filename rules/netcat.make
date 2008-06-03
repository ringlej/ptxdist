# -*-makefile-*-
# $Id: template 2606 2005-05-10 21:49:41Z rsc $
#
# Copyright (C) 2005 by Bjoern Buerger <b.buerger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETCAT) += netcat

#
# Paths and names
#
NETCAT_VERSION	:= 0.7.1
NETCAT		:= netcat-$(NETCAT_VERSION)
NETCAT_SUFFIX	:= tar.gz
NETCAT_URL	:= $(PTXCONF_SETUP_SFMIRROR)/netcat/$(NETCAT).$(NETCAT_SUFFIX)
NETCAT_SOURCE	:= $(SRCDIR)/$(NETCAT).$(NETCAT_SUFFIX)
NETCAT_DIR	:= $(BUILDDIR)/$(NETCAT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

netcat_get: $(STATEDIR)/netcat.get

$(STATEDIR)/netcat.get: $(netcat_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NETCAT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NETCAT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

netcat_extract: $(STATEDIR)/netcat.extract

$(STATEDIR)/netcat.extract: $(netcat_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NETCAT_DIR))
	@$(call extract, NETCAT)
	@$(call patchin, NETCAT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

netcat_prepare: $(STATEDIR)/netcat.prepare

NETCAT_PATH	:= PATH=$(CROSS_PATH)
NETCAT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
NETCAT_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_NETCAT_OLD_HEXDUMP
NETCAT_AUTOCONF += --enable-oldhexdump
else
NETCAT_AUTOCONF += --disable-oldhexdump
endif

ifdef PTXCONF_NETCAT_OLD_TELNET
NETCAT_AUTOCONF += --enable-oldtelnet
else
NETCAT_AUTOCONF += --disable-oldtelnet
endif


$(STATEDIR)/netcat.prepare: $(netcat_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NETCAT_DIR)/config.cache)
	cd $(NETCAT_DIR) && \
		$(NETCAT_PATH) $(NETCAT_ENV) \
		./configure $(NETCAT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

netcat_compile: $(STATEDIR)/netcat.compile

$(STATEDIR)/netcat.compile: $(netcat_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NETCAT_DIR) && $(NETCAT_ENV) $(NETCAT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

netcat_install: $(STATEDIR)/netcat.install

$(STATEDIR)/netcat.install: $(netcat_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, NETCAT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

netcat_targetinstall: $(STATEDIR)/netcat.targetinstall

$(STATEDIR)/netcat.targetinstall: $(netcat_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, netcat)
	@$(call install_fixup, netcat,PACKAGE,netcat)
	@$(call install_fixup, netcat,PRIORITY,optional)
	@$(call install_fixup, netcat,VERSION,$(NETCAT_VERSION))
	@$(call install_fixup, netcat,SECTION,base)
	@$(call install_fixup, netcat,AUTHOR,"Bjoern Buerger <b.buerger\@pengutronix.de>")
	@$(call install_fixup, netcat,DEPENDS,)
	@$(call install_fixup, netcat,DESCRIPTION,missing)

	@$(call install_copy, netcat, 0, 0, 0755, $(NETCAT_DIR)/src/netcat, /bin/netcat)
	@$(call install_link, netcat, netcat, /bin/nc)

	@$(call install_finish, netcat)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

netcat_clean:
	rm -rf $(STATEDIR)/netcat.*
	rm -rf $(PKGDIR)/netcat_*
	rm -rf $(NETCAT_DIR)

# vim: syntax=make

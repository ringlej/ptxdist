# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WIRELESS) += wireless

#
# Paths and names
#
WIRELESS_VERSION	= 28
WIRELESS		= wireless_tools.$(WIRELESS_VERSION)
WIRELESS_SUFFIX		= tar.gz
WIRELESS_URL		= http://pcmcia-cs.sourceforge.net/ftp/contrib/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_SOURCE		= $(SRCDIR)/$(WIRELESS).$(WIRELESS_SUFFIX)
WIRELESS_DIR 		= $(BUILDDIR)/$(WIRELESS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wireless_get: $(STATEDIR)/wireless.get

$(STATEDIR)/wireless.get: $(wireless_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(WIRELESS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, WIRELESS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wireless_extract: $(STATEDIR)/wireless.extract

$(STATEDIR)/wireless.extract: $(wireless_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WIRELESS_DIR))
	@$(call extract, WIRELESS)
	@$(call patchin, WIRELESS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wireless_prepare: $(STATEDIR)/wireless.prepare

$(STATEDIR)/wireless.prepare: $(wireless_prepare_deps_default)
	@$(call targetinfo, $@)
ifdef PTXCONF_WIRELESS_SHARED
	@$(call disable_sh,$(WIRELESS_DIR)/Makefile,BUILD_STATIC)
else
	@$(call enable_sh, $(WIRELESS_DIR)/Makefile,BUILD_STATIC)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

WIRELESS_PATH	=  PATH=$(CROSS_PATH)
WIRELESS_ENV 	=  $(CROSS_ENV)

wireless_compile: $(STATEDIR)/wireless.compile

$(STATEDIR)/wireless.compile: $(wireless_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(WIRELESS_DIR) && $(WIRELESS_PATH) $(WIRELESS_ENV) make CC=${CROSS_CC}
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wireless_install: $(STATEDIR)/wireless.install

$(STATEDIR)/wireless.install: $(wireless_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wireless_targetinstall: $(STATEDIR)/wireless.targetinstall

$(STATEDIR)/wireless.targetinstall: $(wireless_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, wireless)
	@$(call install_fixup, wireless,PACKAGE,wireless)
	@$(call install_fixup, wireless,PRIORITY,optional)
	@$(call install_fixup, wireless,VERSION,$(WIRELESS_VERSION))
	@$(call install_fixup, wireless,SECTION,base)
	@$(call install_fixup, wireless,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, wireless,DEPENDS,)
	@$(call install_fixup, wireless,DESCRIPTION,missing)

	@$(call install_copy, wireless, 0, 0, 0755, $(WIRELESS_DIR)/iwconfig, /usr/sbin/iwconfig)
	@$(call install_copy, wireless, 0, 0, 0755, $(WIRELESS_DIR)/iwlist, /usr/sbin/iwlist)
	@$(call install_copy, wireless, 0, 0, 0755, $(WIRELESS_DIR)/iwpriv, /usr/sbin/iwpriv)
	@$(call install_copy, wireless, 0, 0, 0755, $(WIRELESS_DIR)/iwspy, /usr/sbin/iwspy)
	@$(call install_copy, wireless, 0, 0, 0755, $(WIRELESS_DIR)/iwgetid, /usr/sbin/iwgetid)
	@$(call install_copy, wireless, 0, 0, 0755, $(WIRELESS_DIR)/iwevent, /usr/sbin/iwevent)

ifdef PTXCONF_WIRELESS_SHARED
	@$(call install_copy, wireless, 0, 0, 0644, $(WIRELESS_DIR)/libiw.so.$(WIRELESS_VERSION), \
		/usr/lib/libiw.so.$(WIRELESS_VERSION))
endif

	@$(call install_finish, wireless)

	@$(call touch, $@)
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wireless_clean:
	rm -rf $(STATEDIR)/wireless.*
	rm -rf $(PKGDIR)/wireless_*
	rm -rf $(WIRELESS_DIR)

# vim: syntax=make

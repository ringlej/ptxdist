# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTELNETD) += utelnetd

#
# Paths and names 
#
UTELNETD_VERSION		= 0.1.6
UTELNETD			= utelnetd-$(UTELNETD_VERSION)
UTELNETD_URL			= http://www.pengutronix.de/software/utelnetd/$(UTELNETD).tar.gz
UTELNETD_SOURCE			= $(SRCDIR)/$(UTELNETD).tar.gz
UTELNETD_DIR			= $(BUILDDIR)/$(UTELNETD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

utelnetd_get: $(STATEDIR)/utelnetd.get

$(STATEDIR)/utelnetd.get: $(utelnetd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UTELNETD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, UTELNETD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

utelnetd_extract: $(STATEDIR)/utelnetd.extract

$(STATEDIR)/utelnetd.extract: $(utelnetd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UTELNETS_DIR))
	@$(call extract, UTELNETD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

utelnetd_prepare: $(STATEDIR)/utelnetd.prepare

$(STATEDIR)/utelnetd.prepare: $(utelnetd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

utelnetd_compile: $(STATEDIR)/utelnetd.compile

UTELNETD_ENVIRONMENT += PATH=$(CROSS_PATH)
UTELNETD_MAKEVARS    += CROSS=$(COMPILER_PREFIX)

$(STATEDIR)/utelnetd.compile: $(utelnetd_compile_deps_default)
	@$(call targetinfo, $@)
	$(UTELNETD_ENVIRONMENT) make -C $(UTELNETD_DIR) $(UTELNETD_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

utelnetd_install: $(STATEDIR)/utelnetd.install

$(STATEDIR)/utelnetd.install: $(utelnetd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

utelnetd_targetinstall: $(STATEDIR)/utelnetd.targetinstall

$(STATEDIR)/utelnetd.targetinstall: $(utelnetd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, utelnetd)
	@$(call install_fixup, utelnetd,PACKAGE,utelnetd)
	@$(call install_fixup, utelnetd,PRIORITY,optional)
	@$(call install_fixup, utelnetd,VERSION,$(UTELNETD_VERSION))
	@$(call install_fixup, utelnetd,SECTION,base)
	@$(call install_fixup, utelnetd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, utelnetd,DEPENDS,)
	@$(call install_fixup, utelnetd,DESCRIPTION,missing)
ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD
ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD_DEFAULT 
	@$(call install_copy, utelnetd, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/telnetd, \
		/etc/init.d/telnetd, n)
else
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_TELNETD_USER_FILE),"")
	@$(call install_copy, utelnetd, 0, 0, 0755, $(PTXCONF_ROOTFS_ETC_INITD_TELNETD_USER_FILE), /etc/init.d/telnetd, n)
endif
endif
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK),"")
	@$(call install_copy, utelnetd, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, utelnetd, ../init.d/telnetd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK))
endif
endif

	@$(call install_copy, utelnetd, 0, 0, 0755, $(UTELNETD_DIR)/utelnetd, /sbin/utelnetd)

	@$(call install_finish, utelnetd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

utelnetd_clean: 
	rm -rf $(STATEDIR)/utelnetd.* $(UTELNETD_DIR)

# vim: syntax=make

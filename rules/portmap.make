# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PORTMAP) += portmap

#
# Paths and names
#
PORTMAP_VERSION := 5beta
PORTMAP		:= portmap_$(PORTMAP_VERSION)
PORTMAP_SUFFIX	:= tar.gz
PORTMAP_URL	:= ftp://ftp.porcupine.org/pub/security/$(PORTMAP).tar.gz
PORTMAP_SOURCE	:= $(SRCDIR)/$(PORTMAP).tar.gz
PORTMAP_DIR	:= $(BUILDDIR)/$(PORTMAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

portmap_get: $(STATEDIR)/portmap.get

$(STATEDIR)/portmap.get: $(portmap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PORTMAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PORTMAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

portmap_extract: $(STATEDIR)/portmap.extract

$(STATEDIR)/portmap.extract: $(portmap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PORTMAP_DIR))
	@$(call extract, PORTMAP)
	@$(call patchin, PORTMAP)
#
# Attention: TCP-Wrapper will be ignored and not used!
#
#ifndef PTXCONF_TCPWRAPPER
#	sed -ie 's/$$(WRAP_DIR)\/libwrap.a//' $(PORTMAP_DIR)/Makefile
#endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

portmap_prepare: $(STATEDIR)/portmap.prepare

$(STATEDIR)/portmap.prepare: $(portmap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

portmap_compile: $(STATEDIR)/portmap.compile

PORTMAP_ENV		= $(CROSS_ENV)
PORTMAP_PATH		= PATH=$(CROSS_PATH)

ifdef PTXCONF_TCPWRAPPER
PORTMAP_MAKEVARS	= WRAP_DIR=$(SYSROOT)/lib
endif

$(STATEDIR)/portmap.compile: $(portmap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PORTMAP_DIR) && 						\
		$(PORTMAP_ENV) $(PORTMAP_PATH) make $(PORTMAP_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

portmap_install: $(STATEDIR)/portmap.install

$(STATEDIR)/portmap.install: $(portmap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

portmap_targetinstall: $(STATEDIR)/portmap.targetinstall

$(STATEDIR)/portmap.targetinstall: $(portmap_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, portmap)
	@$(call install_fixup, portmap,PACKAGE,portmap)
	@$(call install_fixup, portmap,PRIORITY,optional)
	@$(call install_fixup, portmap,VERSION,$(PORTMAP_VERSION))
	@$(call install_fixup, portmap,SECTION,base)
	@$(call install_fixup, portmap,AUTHOR,"Juergen Beisert <jbeisert\@netscape.net>")
	@$(call install_fixup, portmap,DEPENDS,)
	@$(call install_fixup, portmap,DESCRIPTION,missing)

ifdef PTXCONF_PORTMAP_INSTALL_PORTMAPPER
	@$(call install_copy, portmap, 0, 0, 0755, $(PORTMAP_DIR)/portmap, \
		/sbin/portmap)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_PORTMAP_DEFAULT
# install the generic one
	@$(call install_copy, portmap, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/portmapd, \
		/etc/init.d/portmapd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_PORTMAP_USER
# install users one
	@$(call install_copy, portmap, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/portmapd, \
		/etc/init.d/portmapd, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_PORTMAP_LINK),"")
	@$(call install_copy, portmap, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, portmap, ../init.d/portmapd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_PORTMAP_LINK))
endif


	@$(call install_finish, portmap)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

portmap_clean:
	rm -rf $(STATEDIR)/portmap.*
	rm -rf $(IMAGEDIR)/portmap_*
	rm -rf $(PORTMAP_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: template 2680 2005-05-27 10:29:43Z rsc $
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
PACKAGES-$(PTXCONF_CHRONY) += chrony

#
# Paths and names
#
CHRONY_VERSION	:= 1.23
CHRONY		:= chrony-$(CHRONY_VERSION)
CHRONY_SUFFIX	:= tar.gz
CHRONY_URL	:= http://chrony.sunsite.dk/download/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_SOURCE	:= $(SRCDIR)/$(CHRONY).$(CHRONY_SUFFIX)
CHRONY_DIR	:= $(BUILDDIR)/$(CHRONY)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

chrony_get: $(STATEDIR)/chrony.get

$(STATEDIR)/chrony.get: $(chrony_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CHRONY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CHRONY)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

chrony_extract: $(STATEDIR)/chrony.extract

$(STATEDIR)/chrony.extract: $(chrony_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CHRONY_DIR))
	@$(call extract, CHRONY)
	@$(call patchin, CHRONY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

chrony_prepare: $(STATEDIR)/chrony.prepare

CHRONY_PATH	:=  PATH=$(CROSS_PATH)
CHRONY_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
CHRONY_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-readline

$(STATEDIR)/chrony.prepare: $(chrony_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CHRONY_DIR)/config.cache)
	cd $(CHRONY_DIR) && \
		$(CHRONY_PATH) $(CHRONY_ENV) \
		sh configure $(CHRONY_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

chrony_compile: $(STATEDIR)/chrony.compile

$(STATEDIR)/chrony.compile: $(chrony_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CHRONY_DIR) && $(CHRONY_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

chrony_install: $(STATEDIR)/chrony.install

$(STATEDIR)/chrony.install: $(chrony_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CHRONY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

chrony_targetinstall: $(STATEDIR)/chrony.targetinstall

$(STATEDIR)/chrony.targetinstall: $(chrony_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, chrony)
	@$(call install_fixup, chrony,PACKAGE,chrony)
	@$(call install_fixup, chrony,PRIORITY,optional)
	@$(call install_fixup, chrony,VERSION,$(CHRONY_VERSION))
	@$(call install_fixup, chrony,SECTION,base)
	@$(call install_fixup, chrony,AUTHOR,"PTXdist Base Package <ptxdist\@pengutronix.de>")
	@$(call install_fixup, chrony,DEPENDS,)
	@$(call install_fixup, chrony,DESCRIPTION,missing)

# ---------------------------
# install chrony binaries
#
	@$(call install_copy, chrony, 0, 0, 0755, 			\
		$(CHRONY_DIR)/chronyd, 					\
		/usr/sbin/chronyd)
	@$(call install_copy, chrony, 0, 0, 0755, 			\
		$(CHRONY_DIR)/chronyc, 					\
		/usr/bin/chronyc)

# ---------------------------
# install chrony command helper script on demand
#
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_COMMAND
	@$(call install_copy, chrony, 0, 0, 0755, 			\
		$(PTXDIST_TOPDIR)/generic/usr/bin/chrony_command, 	\
		/usr/bin/chrony_command, n)
endif

# ---------------------------
# generate a config file
#
ifdef PTXCONF_CHRONY_INSTALL_CONFIG
ifdef PTXCONF_CHRONY_DEFAULTCONFIG
# use generic one
	@$(call install_copy, chrony, 0, 0, 0644, 			\
		$(PTXDIST_TOPDIR)/generic/etc/chrony/chrony.conf, 	\
		/etc/chrony/chrony.conf, n)
	@$(call install_copy, chrony, 0, 0, 0600, 			\
		$(PTXDIST_TOPDIR)/generic/etc/chrony/chrony.keys, 	\
		/etc/chrony/chrony.keys, n)
endif
ifdef PTXCONF_CHRONY_USERCONFIG
# users one
	@$(call install_copy, chrony, 0, 0, 0644, 				\
		$(PTXDIST_WORKSPACE)/projectroot/etc/chrony/chrony.conf, 	\
		/etc/chrony/chrony.conf, n)
	@$(call install_copy, chrony, 0, 0, 0600, 				\
		$(PTXDIST_WORKSPACE)/projectroot/etc/chrony/chrony.keys, 	\
		/etc/chrony/chrony.keys, n)
endif
# modify placeholders with data from configuration
	@$(call install_replace, chrony, /etc/chrony/chrony.conf, \
		@UNCONFIGURED_CHRONY_SERVER_IP@, $(PTXCONF_CHRONY_DEFAULT_NTP_SERVER) )

	@$(call install_replace, chrony, /etc/chrony/chrony.keys, \
		@UNCONFIGURED_CHRONY_ACCESS_KEY@, $(PTXCONF_CHRONY_DEFAULT_ACCESS_KEY) )
endif

# ---------------------------
# install startup script on demand
#
ifdef PTXCONF_ROOTFS_ETC_INITD_CHRONY
ifdef PTXCONF_ROOTFS_ETC_INITD_CHRONY_DEFAULT
# generic script with path modifications
	@$(call install_copy, chrony, 0, 0, 0755, 		\
	$(PTXDIST_TOPDIR)/generic/etc/init.d/chrony, 		\
	/etc/init.d/chrony, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_CHRONY_USER
# users one
	@$(call install_copy, chrony, 0, 0, 0755, 		\
	$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/chrony,	\
	 /etc/init.d/chrony, n)
endif
# install link to launch automatically if enabled
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_CHRONY_LINK),"")
	@$(call install_link, chrony, 				\
	../init.d/chrony, 					\
	/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_CHRONY_LINK))
endif
endif

# ---------------------------
# install chrony command helper script
#
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_COMMAND
	@$(call install_copy, chrony, 0, 0, 0755, 			\
		$(PTXDIST_TOPDIR)/generic/usr/bin/chrony_command, 	\
		/usr/bin/chrony_command, n)
endif

# ---------------------------
# install chrony stat convenience wrapper
#
ifdef PTXCONF_CHRONY_INSTALL_CHRONY_STAT
	@$(call install_copy, chrony, 0, 0, 0755, 			\
		$(PTXDIST_TOPDIR)/generic/usr/bin/chrony_stat, 	\
		/usr/bin/chrony_stat, n)
endif


	@$(call install_finish, chrony)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

chrony_clean:
	rm -rf $(STATEDIR)/chrony.*
	rm -rf $(PKGDIR)/chrony_*
	rm -rf $(CHRONY_DIR)

# vim: syntax=make

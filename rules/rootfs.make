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
PACKAGES-$(PTXCONF_ROOTFS) += rootfs

# dummy to make ipkg happy
ROOTFS_VERSION=1.0.0


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rootfs_get: $(STATEDIR)/rootfs.get

$(STATEDIR)/rootfs.get: $(rootfs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(rootfs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rootfs_prepare: $(STATEDIR)/rootfs.prepare

$(STATEDIR)/rootfs.prepare: $(rootfs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rootfs_compile: $(STATEDIR)/rootfs.compile

$(STATEDIR)/rootfs.compile: $(rootfs_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rootfs_install: $(STATEDIR)/rootfs.install

$(STATEDIR)/rootfs.install: $(rootfs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------
#
# Note: For easier maintainance this target was divided into
# four parts:
# 1) start of ipkg
# 2) population of rootfs directory structure
# 3) population of standard configuration files
# 3) generation of inetd configuration
# 4) population of startscripts for packets without this feature
# 5) finishing of ipkg
# Some of this parts are defined here, some in dedicated files.
#
# This part populates the standard configuration files
include ${PTXDIST_TOPDIR}/rules/rootfs_configfiles.inc
# This part generates the inetd configuration
include ${PTXDIST_TOPDIR}/rules/rootfs_inetd.inc
# This part populates some useful scripts into /etc/init.d
include ${PTXDIST_TOPDIR}/rules/rootfs_init_d.inc
#
# Subtarget to create this ipkg
#
rootfs_sub_start_ipkg:
	@$(call targetinfo, rootfs_targetinstall)

	@$(call install_init,  rootfs)
	@$(call install_fixup, rootfs,PACKAGE,rootfs)
	@$(call install_fixup, rootfs,PRIORITY,optional)
	@$(call install_fixup, rootfs,VERSION,$(ROOTFS_VERSION))
	@$(call install_fixup, rootfs,SECTION,base)
	@$(call install_fixup, rootfs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, rootfs,DEPENDS,)
	@$(call install_fixup, rootfs,DESCRIPTION,missing)

# ---------------------------------------------------------
#
# Subtarget to create rootfs' directory structure
#
rootfs_sub_populate_structure:

ifdef PTXCONF_ROOTFS_DEV
	@$(call install_copy, rootfs, 0, 0, 0755, /dev)
endif
ifdef PTXCONF_ROOTFS_DEV_PTS
	@$(call install_copy, rootfs, 0, 0, 0755, /dev/pts)
endif
ifdef PTXCONF_ROOTFS_DEV_INITIAL
	@$(call install_node, rootfs, 0, 0, 0644, c, 1, 3, /dev/null)
	@$(call install_node, rootfs, 0, 0, 0644, c, 1, 5, /dev/zero)
	@$(call install_node, rootfs, 0, 0, 0600, c, 5, 1, /dev/console)
endif
ifdef PTXCONF_ROOTFS_HOME
	@$(call install_copy, rootfs, 0, 0, 2775, /home)
endif
ifdef PTXCONF_ROOTFS_MEDIA
ifneq ($(PTXCONF_ROOTFS_MEDIA1),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA1))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA2),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA2))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA3),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA3))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA4),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA4))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA5),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA5))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA6),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA6))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA7),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA7))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA8),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA8))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA9),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA9))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA10),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA10))
endif
endif
ifdef PTXCONF_ROOTFS_MNT
	@$(call install_copy, rootfs, 0, 0, 0755, /mnt)
endif
ifdef PTXCONF_ROOTFS_PROC
	@$(call install_copy, rootfs, 0, 0, 0555, /proc)
endif
ifdef PTXCONF_ROOTFS_SYS
	@$(call install_copy, rootfs, 0, 0, 0755, /sys)
endif
ifdef PTXCONF_ROOTFS_TMP
	@$(call install_copy, rootfs, 0, 0, 1777, /tmp)
endif
ifdef PTXCONF_ROOTFS_VAR
	@$(call install_copy, rootfs, 0, 0, 0755, /var)
endif
ifdef PTXCONF_ROOTFS_VAR_LOG
	@$(call install_copy, rootfs, 0, 0, 0755, /var/log)
endif
ifdef PTXCONF_ROOTFS_VAR_RUN
	@$(call install_copy, rootfs, 0, 0, 0755, /var/run)
endif
ifdef PTXCONF_ROOTFS_VAR_LOCK
	@$(call install_copy, rootfs, 0, 0, 0755, /var/lock)
endif
# ---------------------------------------------------------

rootfs_targetinstall: $(STATEDIR)/rootfs.targetinstall

$(STATEDIR)/rootfs.targetinstall: $(rootfs_targetinstall_deps_default) \
	rootfs_sub_start_ipkg \
	rootfs_sub_populate_structure \
	populate_init_d_scripts \
	populate_config_files \
	populate_inetd_conf

	@$(call install_finish, rootfs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean:
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)
	rm -rf $(IMAGEDIR)/rootfs_*

# vim: syntax=make

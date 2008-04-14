# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BUSYBOX) += busybox

#
# Paths and names
#
BUSYBOX_VERSION	:= 1.10.0
BUSYBOX		:= busybox-$(BUSYBOX_VERSION)
BUSYBOX_SUFFIX	:= tar.bz2
BUSYBOX_URL	:= http://www.busybox.net/downloads//$(BUSYBOX).$(BUSYBOX_SUFFIX)
BUSYBOX_SOURCE	:= $(SRCDIR)/$(BUSYBOX).$(BUSYBOX_SUFFIX)
BUSYBOX_DIR	:= $(BUILDDIR)/$(BUSYBOX)
BUSYBOX_PKGDIR	:= $(PKGDIR)/$(BUSYBOX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BUSYBOX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BUSYBOX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(BUSYBOX_DIR))
	@$(call extract, BUSYBOX)
	@$(call patchin, BUSYBOX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BUSYBOX_PATH	:= PATH=$(CROSS_PATH)
BUSYBOX_ENV 	:= $(CROSS_ENV)

BUSYBOX_MAKEVARS=\
	ARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	HOSTCC=$(HOSTCC) \
	$(PARALLELMFLAGS)

$(STATEDIR)/busybox.prepare:
	@$(call targetinfo, $@)

	cd $(BUSYBOX_DIR) && \
		$(BUSYBOX_PATH) $(BUSYBOX_ENV) \
		$(MAKE) distclean $(BUSYBOX_MAKEVARS)
	grep -e PTXCONF_BB_CONFIG_ $(PTXDIST_WORKSPACE)/ptxconfig | \
		sed -e 's/PTXCONF_BB_CONFIG_/CONFIG_/g' > $(BUSYBOX_DIR)/.config
	cd $(BUSYBOX_DIR) && yes "" | $(BUSYBOX_PATH) $(BUSYBOX_ENV) $(MAKE) \
		$(BUSYBOX_MAKEVARS) oldconfig
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.compile:
	@$(call targetinfo, $@)
	cd $(BUSYBOX_DIR) && $(BUSYBOX_PATH) $(MAKE) \
		$(BUSYBOX_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.install:
	@$(call targetinfo, $@)
	cd $(BUSYBOX_DIR) && $(BUSYBOX_PATH) $(MAKE) \
		$(BUSYBOX_MAKEVARS) CONFIG_PREFIX=$(SYSROOT) install
	cd $(BUSYBOX_DIR) && $(BUSYBOX_PATH) $(MAKE) \
		$(BUSYBOX_MAKEVARS) CONFIG_PREFIX=$(BUSYBOX_PKGDIR) install
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/busybox.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, busybox)
	@$(call install_fixup, busybox,PACKAGE,busybox)
	@$(call install_fixup, busybox,PRIORITY,optional)
	@$(call install_fixup, busybox,VERSION,$(BUSYBOX_VERSION))
	@$(call install_fixup, busybox,SECTION,base)
	@$(call install_fixup, busybox,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, busybox,DEPENDS,)
	@$(call install_fixup, busybox,DESCRIPTION,missing)

ifdef PTXCONF_BB_CONFIG_FEATURE_SUID
	@$(call install_copy, busybox, 0, 0, 4755, $(BUSYBOX_DIR)/busybox, /bin/busybox)
else
	@$(call install_copy, busybox, 0, 0, 755, $(BUSYBOX_DIR)/busybox, /bin/busybox)
endif
	@for file in `cat $(BUSYBOX_DIR)/busybox.links`; do	\
		$(call install_link, busybox, /bin/busybox, $$file);	\
	done

	@$(call install_finish, busybox)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

busybox_clean:
	rm -rf $(STATEDIR)/busybox.*
	rm -rf $(IMAGEDIR)/busybox_*
	rm -rf $(BUSYBOX_DIR)

# vim: syntax=make

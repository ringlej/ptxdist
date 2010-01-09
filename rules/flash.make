# -*-makefile-*-
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
PACKAGES-$(PTXCONF_FLASH) += flash

#
# Paths and names
#
FLASH_VERSION		:= 0.9.5
FLASH			:= flash-$(FLASH_VERSION)
FLASH_URL 		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FLASH).tar.gz
FLASH_SOURCE		:= $(SRCDIR)/$(FLASH).tar.gz
FLASH_DIR 		:= $(BUILDDIR)/$(FLASH)
FLASH_EXTRACT		= gzip -dc

# FIXME: RSC: convert this to use the patch repository; this is a bugfix patch!

FLASH_PATCH		= flash-$(FLASH_VERSION)-ptx2.diff
FLASH_PATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FLASH_PATCH)
FLASH_PATCH_SOURCE	= $(SRCDIR)/$(FLASH_PATCH)
FLASH_PATCH_EXTRACT	= cat


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FLASH_SOURCE):
	@$(call targetinfo)
	@$(call get, FLASH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/flash.extract:
	@$(call targetinfo)
	$(FLASH_EXTRACT) $(FLASH_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	cd $(FLASH_DIR) && patch -p1 < $(FLASH_PATCH_SOURCE)
	@$(call patchin, FLASH, $(FLASH_DIR))
	@$(call touch)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# FIXME: rsc: why this strange path?
FLASH_PATH	= PATH=$(PTXCONF_SYSROOT_TARGET)/$(AUTOCONF257)/bin:$(CROSS_PATH)
FLASH_ENV	= $(CROSS_ENV)

#
# autoconf
#
FLASH_AUTOCONF  =  $(CROSS_AUTOCONF_USR)
FLASH_AUTOCONF	+= --with-ncurses-path=$(NCURSES_DIR)

$(STATEDIR)/flash.prepare:
	@$(call targetinfo)
	@$(call clean, $(FLASH_BUILDDIR))
	mkdir -p $(FLASH_DIR)
	rm -f $(FLASH_DIR)/configure
	cd $(FLASH_DIR) && autoconf
#	# Workaround for broken autoconf magic for cross compilation
	cd $(FLASH_DIR) && \
		ac_cv_func_getpgrp_void=yes	\
		ac_cv_func_setpgrp_void=yes	\
		ac_cv_sizeof_long_long=8	\
		ac_cv_func_memcmp_clean=yes	\
		ac_cv_func_getrlimit=yes	\
		$(FLASH_PATH) $(FLASH_ENV) $(FLASH_DIR)/configure $(FLASH_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flash.install:
	@$(call targetinfo)
	# FIXME
	#@$(call install, FLASH)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, flash)
	@$(call install_fixup, flash,PACKAGE,flash)
	@$(call install_fixup, flash,PRIORITY,optional)
	@$(call install_fixup, flash,VERSION,$(FLASH_VERSION))
	@$(call install_fixup, flash,SECTION,base)
	@$(call install_fixup, flash,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, flash,DEPENDS,)
	@$(call install_fixup, flash,DESCRIPTION,missing)

	@$(call install_copy, flash, 0, 0, 0755, $(FLASH_DIR)/flash, /usr/bin/flash)

	# FIMXE: RSC: permissions?
	@$(call install_copy, flash, 0, 0, 0755, $(FLASH_DIR)/modules/alarms, /usr/lib/flash/alarms)
	@$(call install_copy, flash, 0, 0, 0755, $(FLASH_DIR)/modules/background, /usr/lib/flash/background)
	@$(call install_copy, flash, 0, 0, 0755, $(FLASH_DIR)/modules/countdown, /usr/lib/flash/countdown)

	@$(call install_finish, flash)

	@$(call touch)
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

flash_clean:
	rm -fr $(STATEDIR)/flash.*
	rm -fr $(PKGDIR)/flash_*
	rm -fr $(FLASH_DIR)

# vim: syntax=make

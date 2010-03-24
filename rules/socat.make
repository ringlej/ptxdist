# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SOCAT) += socat

#
# Paths and names
#
SOCAT_VERSION	:= 1.7.1.1
SOCAT		:= socat-$(SOCAT_VERSION)
SOCAT_SUFFIX		:= tar.bz2
SOCAT_URL		:= http://www.dest-unreach.org/socat/download/$(SOCAT).$(SOCAT_SUFFIX)
SOCAT_SOURCE		:= $(SRCDIR)/$(SOCAT).$(SOCAT_SUFFIX)
SOCAT_DIR		:= $(BUILDDIR)/$(SOCAT)
SOCAT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SOCAT_SOURCE):
	@$(call targetinfo)
	@$(call get, SOCAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SOCAT_PATH	:= PATH=$(CROSS_PATH)
SOCAT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SOCAT_AUTOCONF := $(CROSS_AUTOCONF_USR)
ifneq ($(PTXCONF_SOCAT_PREDEF_CRDLY_SHIFT),)
SOCAT_AUTOCONF += sc_cv_sys_crdly_shift=$(PTXCONF_SOCAT_PREDEF_CRDLY_SHIFT)
endif
ifneq ($(PTXCONF_SOCAT_PREDEF_TABDLY_SHIFT),)
SOCAT_AUTOCONF += sc_cv_sys_tabdly_shift=$(PTXCONF_SOCAT_PREDEF_TABDLY_SHIFT)
endif
ifneq ($(PTXCONF_SOCAT_PREDEF_CSIZE_SHIFT),)
SOCAT_AUTOCONF += sc_cv_sys_csize_shift=$(PTXCONF_SOCAT_PREDEF_CSIZE_SHIFT)
endif

$(STATEDIR)/socat.prepare:
	@$(call targetinfo)
	@$(call clean, $(SOCAT_DIR)/config.cache)
	(cd $(SOCAT_DIR); \
		$(SOCAT_PATH) $(SOCAT_ENV) \
		./configure $(SOCAT_AUTOCONF); \
		sed -i 's/#define HAVE_TERMIOS_ISPEED 1/#undef HAVE_TERMIOS_ISPEED/g' config.h \
	)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/socat.compile:
#	@$(call targetinfo)
#	cd $(SOCAT_DIR) && $(SOCAT_PATH) $(MAKE) $(PARALLELMFLAGS)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/socat.install:
#	@$(call targetinfo)
#	@$(call install, SOCAT)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/socat.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  socat)
	@$(call install_fixup, socat,PACKAGE,socat)
	@$(call install_fixup, socat,PRIORITY,optional)
	@$(call install_fixup, socat,VERSION,$(SOCAT_VERSION))
	@$(call install_fixup, socat,SECTION,base)
	@$(call install_fixup, socat,AUTHOR,"Jon Ringle")
	@$(call install_fixup, socat,DEPENDS,)
	@$(call install_fixup, socat,DESCRIPTION,missing)

	@$(call install_copy, socat, 0, 0, 0755, $(SOCAT_DIR)/socat, /usr/bin/socat)
	@$(call install_copy, socat, 0, 0, 0755, $(SOCAT_DIR)/procan, /usr/bin/procan)
	@$(call install_copy, socat, 0, 0, 0755, $(SOCAT_DIR)/filan, /usr/bin/filan)

	@$(call install_finish, socat)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

socat_clean:
	rm -rf $(STATEDIR)/socat.*
	rm -rf $(PKGDIR)/socat_*
	rm -rf $(SOCAT_DIR)

# vim: syntax=make

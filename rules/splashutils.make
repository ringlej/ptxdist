# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPLASHUTILS) += splashutils

#
# Paths and names
#
SPLASHUTILS_VERSION	:= 1.5.4.3
SPLASHUTILS		:= splashutils-$(SPLASHUTILS_VERSION)
SPLASHUTILS_SUFFIX	:= tar.bz2
SPLASHUTILS_URL		:= http://download.berlios.de/fbsplash/splashutils-lite-$(SPLASHUTILS_VERSION).$(SPLASHUTILS_SUFFIX)
SPLASHUTILS_SOURCE	:= $(SRCDIR)/splashutils-lite-$(SPLASHUTILS_VERSION).$(SPLASHUTILS_SUFFIX)
SPLASHUTILS_DIR		:= $(BUILDDIR)/$(SPLASHUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SPLASHUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, SPLASHUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPLASHUTILS_PATH	:= PATH=$(CROSS_PATH)
SPLASHUTILS_ENV 	:= $(CROSS_ENV)
SPLASHUTILS_MAKE_PAR	:= NO

#
# autoconf
#
SPLASHUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-gpm \
	--disable-helper \
	--disable-fbcondecor

ifdef PTXCONF_SPLASHUTILS_MNG
SPLASHUTILS_AUTOCONF += --with-mng
else
SPLASHUTILS_AUTOCONF += --without-mng
endif

ifdef PTXCONF_SPLASHUTILS_PNG
SPLASHUTILS_AUTOCONF += --with-png
else
SPLASHUTILS_AUTOCONF += --without-png
endif

ifdef PTXCONF_SPLASHUTILS_TTG
SPLASHUTILS_AUTOCONF += --with-ttf --with-ttf-kernel
else
SPLASHUTILS_AUTOCONF += --without-ttf --without-ttf-kernel
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/splashutils.install:
	@$(call targetinfo)
	@$(call install, SPLASHUTILS)
	. ${PTXDIST_PTXCONFIG}; \
	sed -e "s/@PTXCONF_SPLASHUTILS_THEME@/$$PTXCONF_SPLASHUTILS_THEME/g" \
	    -e "s/@PTXCONF_SPLASHUTILS_BOOTMSG@/$$PTXCONF_SPLASHUTILS_BOOTMSG/" \
		-i $(SPLASHUTILS_PKGDIR)/sbin/splash-functions.sh
	@$(call touch)
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/splashutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  splashutils)
	@$(call install_fixup, splashutils,PACKAGE,splashutils)
	@$(call install_fixup, splashutils,PRIORITY,optional)
	@$(call install_fixup, splashutils,VERSION,$(SPLASHUTILS_VERSION))
	@$(call install_fixup, splashutils,SECTION,base)
	@$(call install_fixup, splashutils,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, splashutils,DEPENDS,)
	@$(call install_fixup, splashutils,DESCRIPTION,missing)

	@$(call install_copy, splashutils, 0, 0, 0755, /lib/splash/cache)

	@$(call install_copy, splashutils, 0, 0, 0755, -, /usr/sbin/fbsplashd)

	@$(call install_copy, splashutils, 0, 0, 0644, -, /usr/lib/libfbsplashrender.so.1.0.0)
	@$(call install_link, splashutils, libfbsplashrender.so.1.0.0, /usr/lib/libfbsplashrender.so.1)
	@$(call install_link, splashutils, libfbsplashrender.so.1.0.0, /usr/lib/libfbsplashrender.so)

	@$(call install_copy, splashutils, 0, 0, 0644, -, /usr/lib/libfbsplash.so.1.0.0)
	@$(call install_link, splashutils, libfbsplash.so.1.0.0, /usr/lib/libfbsplash.so.1)
	@$(call install_link, splashutils, libfbsplash.so.1.0.0, /usr/lib/libfbsplash.so)

	@$(call install_copy, splashutils, 0, 0, 0755, -, /sbin/fbsplashctl)
	@$(call install_link, splashutils, fbsplashctl, /sbin/fbcondecor_ctl.static)
	@$(call install_link, splashutils, fbsplashctl, /sbin/fbsplashd.static)
	@$(call install_link, splashutils, fbsplashctl, /sbin/splash_util.static)

	@$(call install_copy, splashutils, 0, 0, 0755, -, /sbin/splash-functions.sh,n)

	@$(call install_copy, splashutils, 0, 0, 0755, /dev)
	@$(call install_node, splashutils, 0, 0, 0600, c, 29, 0, /dev/fb0)
	@$(call install_node, splashutils, 0, 0, 0600, c, 4, 0, /dev/tty0)
	@$(call install_node, splashutils, 0, 0, 0600, c, 4, 16, /dev/tty16)

	@$(call install_alternative, splashutils, 0, 0, 0755, /etc/init.d/splashutils)
	@$(call install_link, splashutils, ../init.d/splashutils, /etc/rc.d/S000splashutils)

	@$(call install_finish, splashutils)

	@$(call touch)

# vim: syntax=make

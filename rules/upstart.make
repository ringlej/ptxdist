# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UPSTART) += upstart

#
# Paths and names
#
UPSTART_VERSION	:= 0.5.1
UPSTART		:= upstart-$(UPSTART_VERSION)
UPSTART_SUFFIX	:= tar.bz2
UPSTART_URL	:= http://upstart.ubuntu.com/download/0.5/$(UPSTART).$(UPSTART_SUFFIX)
UPSTART_SOURCE	:= $(SRCDIR)/$(UPSTART).$(UPSTART_SUFFIX)
UPSTART_DIR	:= $(BUILDDIR)/$(UPSTART)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UPSTART_SOURCE):
	@$(call targetinfo)
	@$(call get, UPSTART)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UPSTART_PATH	:= PATH=$(CROSS_PATH)
UPSTART_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
UPSTART_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--enable-threads=posix \
	--disable-rpath \
	--enable-shared \
	--enable-static \
	--enable-threading \
	--enable-compiler-warnings \
	--enable-compiler-optimisations \
	--disable-compiler-coverage \
	--enable-linker-optimisations \
	--with-gnu-ld \
	--without-libpth-prefix \
	--without-libiconv-prefix \
	--with-included-gettext \
	--without-libintl-prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/upstart.targetinstall:
	@$(call targetinfo)

	@$(call install_init, upstart)
	@$(call install_fixup, upstart,PACKAGE,upstart)
	@$(call install_fixup, upstart,PRIORITY,optional)
	@$(call install_fixup, upstart,VERSION,$(UPSTART_VERSION))
	@$(call install_fixup, upstart,SECTION,base)
	@$(call install_fixup, upstart,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, upstart,DEPENDS,)
	@$(call install_fixup, upstart,DESCRIPTION,missing)

	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/init)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/halt)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/shutdown)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/stop)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/reboot)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/poweroff)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/runlevel)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/telinit)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/start)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/status)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/initctl)

	@$(call install_copy, upstart, 0, 0, 0755, /etc/init.d/conf.d)
	@$(call install_copy, upstart, 0, 0, 0755, /etc/init.d/jobs.d)

	@$(call install_copy, upstart, 0, 0, 0644, -, /etc/dbus-1/system.d/Upstart.conf)

	@$(call install_finish, upstart)

	@$(call touch)

# vim: syntax=make

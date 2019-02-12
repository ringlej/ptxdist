# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ALSA_UTILS) += alsa-utils

#
# Paths and names
#
ALSA_UTILS_VERSION	:= 1.1.7
ALSA_UTILS_MD5		:= 2b88796c6b05520e59eec6049de02f64
ALSA_UTILS		:= alsa-utils-$(ALSA_UTILS_VERSION)
ALSA_UTILS_SUFFIX	:= tar.bz2
ALSA_UTILS_URL		:= \
	http://dl.ambiweb.de/mirrors/ftp.alsa-project.org/utils/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX) \
	ftp://ftp.alsa-project.org/pub/utils/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_SOURCE	:= $(SRCDIR)/$(ALSA_UTILS).$(ALSA_UTILS_SUFFIX)
ALSA_UTILS_DIR		:= $(BUILDDIR)/$(ALSA_UTILS)
ALSA_UTILS_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ALSA_UTILS_CONF_TOOL	:= autoconf
ALSA_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--disable-alsatest \
	--disable-bat \
	--$(call ptx/endis, PTXCONF_ALSA_UTILS_ALSAMIXER)-alsamixer \
	--$(call ptx/endis, PTXCONF_ALSA_UTILS_ALSALOOP)-alsaloop \
	--disable-xmlto \
	--disable-rst2man \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--with-curses=$(call ptx/ifdef,PTXCONF_ALSA_UTILS_ALSAMIXER,$(call ptx/ifdef,PTXCONF_NCURSES_WIDE_CHAR,ncursesw,ncurses),no) \
	--with-systemdsystemunitdir=$(call ptx/ifdef,PTXCONF_ALSA_UTILS_SYSTEMD_UNIT,/usr/lib/systemd/system,no) \
	--with-asound-state-dir=/etc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alsa-utils)
	@$(call install_fixup, alsa-utils, PRIORITY, optional)
	@$(call install_fixup, alsa-utils, SECTION, base)
	@$(call install_fixup, alsa-utils, AUTHOR, "Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, alsa-utils, DESCRIPTION, missing)

	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/sbin/alsactl)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/amidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/amixer)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aplay)
#	# link arecord aplay
	@$(call install_link, alsa-utils, aplay, /usr/bin/arecord)

	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/iecset)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aconnect)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aplaymidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/arecordmidi)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aseqdump)
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/aseqnet)

ifdef PTXCONF_ALSA_UTILS_ALSAMIXER
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/alsamixer)
endif
ifdef PTXCONF_ALSA_UTILS_ALSALOOP
	@$(call install_copy, alsa-utils, 0, 0, 0755, -, /usr/bin/alsaloop)
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_ALSA_UTILS_STARTSCRIPT
	@$(call install_alternative, alsa-utils, 0, 0, 0755, /etc/init.d/alsa-utils, n)
ifneq ($(call remove_quotes,$(PTXCONF_ALSA_UTILS_BBINIT_LINK)),)
	@$(call install_link, alsa-utils, \
		../init.d/alsa-utils, \
		/etc/rc.d/$(PTXCONF_ALSA_UTILS_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_ALSA_UTILS_SYSTEMD_UNIT
	@$(call install_alternative, alsa-utils, 0, 0, 0644, \
		/usr/lib/systemd/system/alsa-restore.service)
	@$(call install_link, alsa-utils, ../alsa-restore.service, \
		/usr/lib/systemd/system/basic.target.wants/alsa-restore.service)
endif

ifdef PTXCONF_ALSA_UTILS_ASOUND_STATE
	@$(call install_alternative, alsa-utils, 0, 0, 0644, \
		/etc/asound.state, n)
endif
	@$(call install_finish, alsa-utils)

	@$(call touch)

# vim: syntax=make


# -*-makefile-*-
#
# Copyright (C) 2003 by wschmitt@envicomp.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RSYNC) += rsync

#
# Paths and names
#
RSYNC_VERSION	:= 2.6.8
RSYNC		:= rsync-$(RSYNC_VERSION)
RSYNC_SUFFIX	:= tar.gz
RSYNC_URL	:= http://samba.org/ftp/rsync/src/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_SOURCE	:= $(SRCDIR)/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_DIR	:= $(BUILDDIR)/$(RSYNC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RSYNC_SOURCE):
	@$(call targetinfo)
	@$(call get, RSYNC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RSYNC_PATH	:= PATH=$(CROSS_PATH)
RSYNC_ENV 	:= \
	$(CROSS_ENV) \
	rsync_cv_HAVE_GETTIMEOFDAY_TZ=yes 

#
# autoconf
#
RSYNC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-included-popt \
	--disable-debug \
	--disable-locale

ifdef PTXCONF_RSYNC_LARGE_FILE
RSYNC_AUTOCONF += --enable-largefile
else
RSYNC_AUTOCONF += --disable-largefile
endif

ifdef PTXCONF_RSYNC_IPV6
RSYNC_AUTOCONF += --enable-ipv6
else
RSYNC_AUTOCONF += --disable-ipv6
endif

ifneq ($(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)),)
RSYNC_AUTOCONF += --with-rsyncd-conf=$(PTXCONF_RSYNC_CONFIG_FILE)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsync.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  rsync)
	@$(call install_fixup, rsync,PACKAGE,rsync)
	@$(call install_fixup, rsync,PRIORITY,optional)
	@$(call install_fixup, rsync,VERSION,$(RSYNC_VERSION))
	@$(call install_fixup, rsync,SECTION,base)
	@$(call install_fixup, rsync,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, rsync,DEPENDS,)
	@$(call install_fixup, rsync,DESCRIPTION,missing)

	@$(call install_copy, rsync, 0, 0, 0755, -, \
		/usr/bin/rsync)

	@$(call install_alternative, rsync, 0, 0, 0644, /etc/rsyncd.conf, n)
	@$(call install_alternative, rsync, 0, 0, 0644, /etc/rsyncd.secrets, n)

ifdef PTXCONF_RSYNC_STARTUP_TYPE_STANDALONE
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_RSYNC_STARTSCRIPT
	@$(call install_alternative, rsync, 0, 0, 0755, /etc/init.d/rsyncd, n)
	@$(call install_replace, rsync, /etc/init.d/rsyncd, \
		@CONFIG@, \
		"--config=$(PTXCONF_RSYNC_CONFIG_FILE)" )
endif
endif
endif

ifdef PTXCONF_RSYNC_INETD_SERVER
	@$(call install_alternative, rsync, 0, 0, 0644, /etc/inetd.conf.d/rsync, n)
	@$(call install_replace, rsync, /etc/inetd.conf.d/rsync, \
		@CONFIG@, "--config=$(PTXCONF_RSYNC_CONFIG_FILE)" )
endif

	@$(call install_finish, rsync)
	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_RSYNC3) += rsync3

#
# Paths and names
#
RSYNC3_VERSION	:= 3.0.5
RSYNC3		:= rsync-$(RSYNC3_VERSION)
RSYNC3_SUFFIX	:= tar.gz
RSYNC3_URL	:= http://rsync.samba.org/ftp/rsync/src/$(RSYNC3).$(RSYNC3_SUFFIX)
RSYNC3_SOURCE	:= $(SRCDIR)/$(RSYNC3).$(RSYNC3_SUFFIX)
RSYNC3_DIR	:= $(BUILDDIR)/$(RSYNC3)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RSYNC3_SOURCE):
	@$(call targetinfo)
	@$(call get, RSYNC3)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RSYNC3_PATH	:= PATH=$(CROSS_PATH)
RSYNC3_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
RSYNC3_AUTOCONF  := \
	 $(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--with-included-popt \
	--disable-debug \
	--disable-locale

ifneq ($(call remove_quotes,$(PTXCONF_RSYNC3_CONFIG_FILE)),)
RSYNC3_AUTOCONF += --with-rsync3d-conf=$(PTXCONF_RSYNC3_CONFIG_FILE)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsync3.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  rsync3)
	@$(call install_fixup, rsync3,PACKAGE,rsync3)
	@$(call install_fixup, rsync3,PRIORITY,optional)
	@$(call install_fixup, rsync3,VERSION,$(RSYNC3_VERSION))
	@$(call install_fixup, rsync3,SECTION,base)
	@$(call install_fixup, rsync3,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, rsync3,DEPENDS,)
	@$(call install_fixup, rsync3,DESCRIPTION,missing)

	@$(call install_copy, rsync3, 0, 0, 0755, -, \
		/usr/bin/rsync)

	@$(call install_alternative, rsync3, 0, 0, 0644, /etc/rsyncd.conf, n)
	@$(call install_alternative, rsync3, 0, 0, 0640, /etc/rsyncd.secrets, n)

	#
	# busybox init
	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_RSYNC3_STARTSCRIPT
	@$(call install_alternative, rsync3, 0, 0, 0755, /etc/init.d/rsyncd, n)
endif
endif
	@$(call install_finish, rsync3)
	@$(call touch)

# vim: syntax=make

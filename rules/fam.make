# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAM) += fam

#
# Paths and names
#
FAM_VERSION	:= 2.7.0
FAM		:= fam-$(FAM_VERSION)
FAM_SUFFIX	:= tar.gz
FAM_URL		:= ftp://oss.sgi.com/projects/fam/download/stable/$(FAM).$(FAM_SUFFIX)
FAM_SOURCE	:= $(SRCDIR)/$(FAM).$(FAM_SUFFIX)
FAM_DIR		:= $(BUILDDIR)/$(FAM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------
$(FAM_SOURCE):
	@$(call targetinfo)
	@$(call get, FAM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FAM_PATH	:= PATH=$(CROSS_PATH)
FAM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FAM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fam.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fam)
	@$(call install_fixup,fam,PACKAGE,fam)
	@$(call install_fixup,fam,PRIORITY,optional)
	@$(call install_fixup,fam,VERSION,$(FAM_VERSION))
	@$(call install_fixup,fam,SECTION,base)
	@$(call install_fixup,fam,AUTHOR,"Juergen Beisert <j.beisert\@pengutronix.de>")
	@$(call install_fixup,fam,DEPENDS,)
	@$(call install_fixup,fam,DESCRIPTION,missing)

	@$(call install_copy, fam, 0, 0, 0755, $(FAM_DIR)/src/famd, \
		/usr/sbin/famd)
ifdef PTXCONF_FAM_DEFAULT_CONF
	@$(call install_copy, fam, 0, 0, 0755, $(FAM_DIR)/conf/fam.conf, \
		/etc/fam.conf, n)
endif
ifdef PTXCONF_FAM_LIBRARY
	@$(call install_copy, fam, 0, 0, 0644, \
		$(FAM_DIR)/lib/.libs/libfam.so.0.0.0, \
		/usr/lib/libfam.so.0.0.0)
	@$(call install_link, fam, /usr/lib/libfam.so.0.0.0, \
		/usr/lib/libfam.so.0)
	@$(call install_link, fam, /usr/lib/libfam.so.0.0.0, \
		/usr/lib/libfam.so)
endif

ifdef PTXCONF_FAM_STARTUP_TYPE_STANDALONE
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_FAM_STARTSCRIPT
	@$(call install_alternative, fam, 0, 0, 0755, /etc/init.d/famd, n)
endif
endif
endif

ifdef PTXCONF_FAM_INETD_SERVER
	@$(call install_alternative, fam, 0, 0, 0644, /etc/inetd.conf.d/fam, n)
endif

	@$(call install_finish,fam)

	@$(call touch)

# vim: syntax=make

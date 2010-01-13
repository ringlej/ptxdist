# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PEKWM) += pekwm

#
# Paths and names
#
PEKWM_VERSION	:= 0.1.4
PEKWM		:= pekwm-$(PEKWM_VERSION)
PEKWM_SUFFIX	:= tar.bz2
PEKWM_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(PEKWM).$(PEKWM_SUFFIX)
PEKWM_SOURCE	:= $(SRCDIR)/$(PEKWM).$(PEKWM_SUFFIX)
PEKWM_DIR	:= $(BUILDDIR)/$(PEKWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PEKWM_SOURCE):
	@$(call targetinfo)
	@$(call get, PEKWM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PEKWM_PATH	:= PATH=$(CROSS_PATH)
PEKWM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PEKWM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--x-includes=$(SYSROOT)/usr/include \
	--x-libraries=$(SYSROOT)/usr/lib \
	--disable-xft

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pekwm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pekwm)
	@$(call install_fixup,pekwm,PACKAGE,pekwm)
	@$(call install_fixup,pekwm,PRIORITY,optional)
	@$(call install_fixup,pekwm,VERSION,$(PEKWM_VERSION))
	@$(call install_fixup,pekwm,SECTION,base)
	@$(call install_fixup,pekwm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pekwm,DEPENDS,)
	@$(call install_fixup,pekwm,DESCRIPTION,missing)

	@$(call install_copy, pekwm, 0, 0, 0755, -, /usr/bin/pekwm)

ifdef PTXCONF_PEKWM_INSTALL_CONFIG
	@for file in /etc/pekwm/{autoproperties,config,keys,menu,mouse,start,vars}; do \
		$(call install_copy, pekwm, 0, 0, 0755, -, $$file); \
	done
endif

ifdef  PTXCONF_PEKWM_INSTALL_THEME
	@$(call install_copy, pekwm, 0, 0, 0755, -, \
		/usr/share/pekwm/themes/default/theme)
endif

	@$(call install_finish,pekwm)

	@$(call touch)

# vim: syntax=make

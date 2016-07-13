# -*-makefile-*-
#
# Copyright (C) 2015 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNEWT) += libnewt

#
# Paths and names
#
LIBNEWT_VERSION	:= 0.52.18
LIBNEWT_MD5	:= 685721bee1a318570704b19dcf31d268
LIBNEWT		:= newt-$(LIBNEWT_VERSION)
LIBNEWT_SUFFIX	:= tar.gz
LIBNEWT_URL	:= https://fedorahosted.org/releases/n/e/newt/$(LIBNEWT).$(LIBNEWT_SUFFIX)
LIBNEWT_SOURCE	:= $(SRCDIR)/$(LIBNEWT).$(LIBNEWT_SUFFIX)
LIBNEWT_DIR	:= $(BUILDDIR)/$(LIBNEWT)
LIBNEWT_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNEWT_CONF_TOOL	:= autoconf
LIBNEWT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--without-python \
	--without-tcl \
	--without-gpm-support

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnewt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnewt)
	@$(call install_fixup, libnewt,PRIORITY,optional)
	@$(call install_fixup, libnewt,SECTION,base)
	@$(call install_fixup, libnewt,AUTHOR,"Juergen Borleis <jbe@pengutronix.de>")
	@$(call install_fixup, libnewt,DESCRIPTION,"Not Eriks Windowing Toolkit")

	@$(call install_lib, libnewt, 0, 0, 0644, libnewt)

	@$(call install_finish, libnewt)

	@$(call touch)

# vim: syntax=make

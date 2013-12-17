# -*-makefile-*-
#
# Copyright (C) 2013 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTREMOR) += libtremor

LIBTREMOR_VERSION	:= 1.0.3
LIBTREMOR_MD5		:= 31074f67ca36a3f8e6c8225c9126cde0
LIBTREMOR		:= libtremor-$(LIBTREMOR_VERSION)
LIBTREMOR_SUFFIX	:= tar.gz
LIBTREMOR_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBTREMOR).$(LIBTREMOR_SUFFIX)
LIBTREMOR_SOURCE	:= $(SRCDIR)/$(LIBTREMOR).$(LIBTREMOR_SUFFIX)
LIBTREMOR_DIR		:= $(BUILDDIR)/$(LIBTREMOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTREMOR_CONF_TOOL	:= autoconf
LIBTREMOR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static

ifdef PTXCONF_ARCH_ARM
$(STATEDIR)/libtremor.compile: PTXDIST_CROSS_CPPFLAGS += -Wa,-mimplicit-it=thumb
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtremor.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtremor)
	@$(call install_fixup, libtremor,PRIORITY,optional)
	@$(call install_fixup, libtremor,SECTION,base)
	@$(call install_fixup, libtremor,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, libtremor,DESCRIPTION,missing)

	@$(call install_lib, libtremor, 0, 0, 0644, libvorbisidec)

	@$(call install_finish, libtremor)

	@$(call touch)

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XAW) += xorg-lib-xaw

#
# Paths and names
#
XORG_LIB_XAW_VERSION	:= 1.0.11
XORG_LIB_XAW_MD5	:= f39942f2cab379fc9b4c3731bf191b84
XORG_LIB_XAW		:= libXaw-$(XORG_LIB_XAW_VERSION)
XORG_LIB_XAW_SUFFIX	:= tar.bz2
XORG_LIB_XAW_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX))
XORG_LIB_XAW_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAW)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_XAW_CONF_TOOL	:= autoconf
XORG_LIB_XAW_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XAW_V6)-xaw6 \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XAW_V7)-xaw7 \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xaw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xaw)
	@$(call install_fixup, xorg-lib-xaw,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xaw,SECTION,base)
	@$(call install_fixup, xorg-lib-xaw,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xaw,DESCRIPTION,missing)

ifdef PTXCONF_XORG_LIB_XAW_V6
	@$(call install_lib, xorg-lib-xaw, 0, 0, 0644, libXaw6)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw.so.6)
endif

ifdef PTXCONF_XORG_LIB_XAW_V7
	@$(call install_lib, xorg-lib-xaw, 0, 0, 0644, libXaw7)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw.so.7)
endif
	@$(call install_finish, xorg-lib-xaw)

	@$(call touch)

# vim: syntax=make

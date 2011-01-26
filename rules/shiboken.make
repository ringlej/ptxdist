# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SHIBOKEN) += shiboken

#
# Paths and names
#
SHIBOKEN_VERSION	:= 1.0.3
SHIBOKEN_MD5		:= d155d61156c8db25a418b80ade47962f
SHIBOKEN		:= shiboken-$(SHIBOKEN_VERSION)
SHIBOKEN_SUFFIX		:= tar.bz2
SHIBOKEN_URL		:= http://www.pyside.org/files/$(SHIBOKEN).$(SHIBOKEN_SUFFIX)
SHIBOKEN_SOURCE		:= $(SRCDIR)/$(SHIBOKEN).$(SHIBOKEN_SUFFIX)
SHIBOKEN_DIR		:= $(BUILDDIR)/$(SHIBOKEN)
SHIBOKEN_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
SHIBOKEN_CONF_TOOL	:= cmake
SHIBOKEN_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTS:BOOL=OFF

SHIBOKEN_MAKE_OPT	:= -C libshiboken
SHIBOKEN_INSTALL_OPT	:= -C libshiboken install

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/shiboken.install:
	@$(call targetinfo)
	@$(call world/install, SHIBOKEN)
	@cd $(SHIBOKEN_DIR)-build && $(MAKE) -C data install DESTDIR='$(SHIBOKEN_PKGDIR)'
	@$(call touch)

$(STATEDIR)/shiboken.install.post:
	@$(call targetinfo)
	@$(call world/install.post, SHIBOKEN)
	@sed -i -e 's,"/usr/bin,"$(PTXCONF_SYSROOT_HOST)/bin,g' \
		-e 's,"/usr,"$(SYSROOT)/usr,g' \
		'$(SYSROOT)/usr/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig.cmake'
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/shiboken.targetinstall:
	@$(call targetinfo)

	@$(call install_init, shiboken)
	@$(call install_fixup, shiboken,PRIORITY,optional)
	@$(call install_fixup, shiboken,SECTION,base)
	@$(call install_fixup, shiboken,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, shiboken,DESCRIPTION,missing)

	@$(call install_lib, shiboken, 0, 0, 0644, libshiboken)

	@$(call install_finish, shiboken)

	@$(call touch)

# vim: syntax=make

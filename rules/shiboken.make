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
SHIBOKEN_VERSION	:= 1.1.1
SHIBOKEN_MD5		:= fa451b6c4f3e06cce283a84550a96fd2
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
SHIBOKEN_CONF_OPT	= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTS:BOOL=OFF \
	-DPython_PREFERRED_VERSION=python$(PYTHON_MAJORMINOR)

SHIBOKEN_MAKE_OPT	:= -C libshiboken
SHIBOKEN_INSTALL_OPT	:= -C libshiboken install

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/shiboken.install:
	@$(call targetinfo)
	@$(call world/install, SHIBOKEN)
	@cd $(SHIBOKEN_DIR)-build && $(MAKE) -C data install DESTDIR='$(SHIBOKEN_PKGDIR)'
	@sed -i -e 's,"$(SYSROOT)/usr,"SYSROOT/usr,g' \
		-e 's,"$(PTXCONF_SYSROOT_CROSS),"SYSROOT_CROSS,g' \
		'$(SHIBOKEN_PKGDIR)/usr/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig-python$(PYTHON_MAJORMINOR).cmake'
	echo $(PTXCONF_SYSROOT_CROSS)/usr
	@$(call touch)

$(STATEDIR)/shiboken.install.post:
	@$(call targetinfo)
	@$(call world/install.post, SHIBOKEN)
	@sed -i -e 's,(/usr,($(SYSROOT)/usr,g' \
		'$(SYSROOT)/usr/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig.cmake'
	@sed -i -e 's,"SYSROOT_CROSS,"$(PTXCONF_SYSROOT_CROSS),g' \
		-e 's,"SYSROOT/usr,"$(SYSROOT)/usr,g' \
		-e 's,"/usr/bin,"$(PTXCONF_SYSROOT_HOST)/bin,g' \
		-e 's,"/usr,"$(SYSROOT)/usr,g' \
		'$(SYSROOT)/usr/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig-python$(PYTHON_MAJORMINOR).cmake'
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

	@$(call install_lib, shiboken, 0, 0, 0644, \
		libshiboken-python$(PYTHON_MAJORMINOR))

	@$(call install_finish, shiboken)

	@$(call touch)

# vim: syntax=make

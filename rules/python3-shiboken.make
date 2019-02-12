# -*-makefile-*-
#
# Copyright (C) 2016 by Robin van der Gracht <robin@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_SHIBOKEN) += python3-shiboken

#
# Paths and names
#
PYTHON3_SHIBOKEN_VERSION	:= 1.2.2
PYTHON3_SHIBOKEN_MD5		:= 9f5bee9d414ce51be07ff7a20054a48d
PYTHON3_SHIBOKEN		:= shiboken-$(PYTHON3_SHIBOKEN_VERSION)
PYTHON3_SHIBOKEN_SUFFIX		:= tar.bz2
PYTHON3_SHIBOKEN_URL		:= https://download.qt.io/official_releases/pyside/shiboken-$(PYTHON3_SHIBOKEN_VERSION).$(PYTHON3_SHIBOKEN_SUFFIX)
PYTHON3_SHIBOKEN_SOURCE		:= $(SRCDIR)/$(PYTHON3_SHIBOKEN).$(PYTHON3_SHIBOKEN_SUFFIX)
PYTHON3_SHIBOKEN_DIR		:= $(BUILDDIR)/$(PYTHON3_SHIBOKEN)
PYTHON3_SHIBOKEN_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
PYTHON3_SHIBOKEN_CONF_TOOL		:= cmake
PYTHON3_SHIBOKEN_CONF_OPT	= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTS:BOOL=OFF \
	-DUSE_PYTHON3:BOOL=ON \
	-DPython3_PREFERRED_VERSION=python$(PYTHON3_MAJORMINOR)

PYTHON3_SHIBOKEN_MAKE_OPT		:= -C libshiboken
PYTHON3_SHIBOKEN_INSTALL_OPT	:= -C libshiboken install

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-shiboken.install:
	@$(call targetinfo)
	@$(call world/install, PYTHON3_SHIBOKEN)
	@cd $(PYTHON3_SHIBOKEN_DIR)-build && $(MAKE) -C data install DESTDIR='$(PYTHON3_SHIBOKEN_PKGDIR)'
	@sed -i -e 's,"$(SYSROOT)/usr,"SYSROOT/usr,g' \
		-e 's,"$(PTXCONF_SYSROOT_CROSS),"SYSROOT_CROSS,g' \
		$(PYTHON3_SHIBOKEN_PKGDIR)/usr/lib/cmake/Shiboken-$(PYTHON3_SHIBOKEN_VERSION)/ShibokenConfig.cpython*.cmake
	@$(call touch)

$(STATEDIR)/python3-shiboken.install.post:
	@$(call targetinfo)
	@$(call world/install.post, PYTHON3_SHIBOKEN)
	@sed -i -e 's,(/usr,($(SYSROOT)/usr,g' \
		'$(SYSROOT)/usr/lib/cmake/Shiboken-$(PYTHON3_SHIBOKEN_VERSION)/ShibokenConfig.cmake'
	@sed -i -e 's,"SYSROOT_CROSS,"@$(PTXCONF_SYSROOT_CROSS),g' \
		-e 's,"SYSROOT/usr,"@$(SYSROOT)/usr,g' \
		-e 's,"/usr/bin,"@$(PTXCONF_SYSROOT_HOST)/bin,g' \
		-e 's,"/usr,"@$(SYSROOT)/usr,g' \
		-e 's,"@,",g' \
		$(SYSROOT)/usr/lib/cmake/Shiboken-$(PYTHON3_SHIBOKEN_VERSION)/ShibokenConfig.cpython*.cmake
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-shiboken.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-shiboken)
	@$(call install_fixup, python3-shiboken, PRIORITY, optional)
	@$(call install_fixup, python3-shiboken, SECTION, base)
	@$(call install_fixup, python3-shiboken, AUTHOR, "Robin van der Gracht <robin@protonic.nl>")
	@$(call install_fixup, python3-shiboken, DESCRIPTION, missing)

	@$(call install_lib, python3-shiboken, 0, 0, 0644, \
		libshiboken.cpython-*)

	@$(call install_finish, python3-shiboken)

	@$(call touch)

# vim: syntax=make

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
PACKAGES-$(PTXCONF_PYSIDE) += pyside

#
# Paths and names
#
PYSIDE_VERSION	:= 4.8+1.1.1
PYSIDE_MD5	:= 0176d3746074afe47373d7302e1b4501
PYSIDE		:= pyside-qt$(PYSIDE_VERSION)
PYSIDE_SUFFIX	:= tar.bz2
PYSIDE_URL	:= http://www.pyside.org/files/$(PYSIDE).$(PYSIDE_SUFFIX)
PYSIDE_SOURCE	:= $(SRCDIR)/$(PYSIDE).$(PYSIDE_SUFFIX)
PYSIDE_DIR	:= $(BUILDDIR)/$(PYSIDE)
PYSIDE_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
PYSIDE_CONF_TOOL	:= cmake
PYSIDE_CONF_OPT	= \
	$(CROSS_CMAKE_USR) \
	-DQT_SRC_DIR:STRING='$(QT4_DIR)'

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pyside.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pyside)
	@$(call install_fixup, pyside,PRIORITY,optional)
	@$(call install_fixup, pyside,SECTION,base)
	@$(call install_fixup, pyside,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, pyside,DESCRIPTION,missing)

	@$(call install_lib, pyside, 0, 0, 0644, \
		libpyside-python$(PYTHON_MAJORMINOR))
	@$(call install_tree, pyside, 0, 0, \
		$(PYSIDE_PKGDIR)/usr/lib/python2.6/site-packages/PySide, \
		/usr/lib/python2.6/site-packages/PySide)

	@$(call install_finish, pyside)

	@$(call touch)

# vim: syntax=make

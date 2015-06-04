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
PACKAGES-$(PTXCONF_PYTHON_IMAGING) += python-imaging

#
# Paths and names
#
PYTHON_IMAGING_VERSION	:= 1.1.7
PYTHON_IMAGING_MD5	:= fc14a54e1ce02a0225be8854bfba478e
PYTHON_IMAGING		:= Imaging-$(PYTHON_IMAGING_VERSION)
PYTHON_IMAGING_SUFFIX	:= tar.gz
PYTHON_IMAGING_URL	:= http://effbot.org/downloads/$(PYTHON_IMAGING).$(PYTHON_IMAGING_SUFFIX)
PYTHON_IMAGING_SOURCE	:= $(SRCDIR)/$(PYTHON_IMAGING).$(PYTHON_IMAGING_SUFFIX)
PYTHON_IMAGING_DIR	:= $(BUILDDIR)/$(PYTHON_IMAGING)
PYTHON_IMAGING_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_IMAGING_CONF_TOOL	:= python

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-imaging.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-imaging)
	@$(call install_fixup, python-imaging,PRIORITY,optional)
	@$(call install_fixup, python-imaging,SECTION,base)
	@$(call install_fixup, python-imaging,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python-imaging,DESCRIPTION,missing)

	@for file in `find $(PYTHON_IMAGING_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/PIL  \
			! -type d ! -name "*.py" -printf "%f\n"`; do \
		$(call install_copy, python-imaging, 0, 0, 0644, -, \
			/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/PIL/$$file); \
	done

	@$(call install_finish, python-imaging)

	@$(call touch)

# vim: syntax=make

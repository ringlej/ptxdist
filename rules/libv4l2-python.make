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
PACKAGES-$(PTXCONF_LIBV4L2_PYTHON) += libv4l2-python

#
# Paths and names
#
LIBV4L2_PYTHON_VERSION	:= 0.8
LIBV4L2_PYTHON_MD5	:= 89ecc981925552e78cbe4620d62c2c81
LIBV4L2_PYTHON		:= pyDataMatrixScanner
LIBV4L2_PYTHON_SUFFIX	:= tar.gz
LIBV4L2_PYTHON_URL	:= $(call ptx/mirror, SF, pydmscanner/$(LIBV4L2_PYTHON)-$(LIBV4L2_PYTHON_VERSION).$(LIBV4L2_PYTHON_SUFFIX))
LIBV4L2_PYTHON_SOURCE	:= $(SRCDIR)/$(LIBV4L2_PYTHON)-$(LIBV4L2_PYTHON_VERSION).$(LIBV4L2_PYTHON_SUFFIX)
LIBV4L2_PYTHON_DIR	:= $(BUILDDIR)/$(LIBV4L2_PYTHON)
LIBV4L2_PYTHON_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBV4L2_PYTHON_CONF_TOOL	:= NO
LIBV4L2_PYTHON_MAKE_OPT		:= $(CROSS_ENV_CC) CFLAGS="-O2 $(CROSS_CPPFLAGS) $(CROSS_LDFLAGS)"

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libv4l2-python.install:
	@$(call targetinfo)
	PATH=$(CROSS_PATH) python -m compileall $(LIBV4L2_PYTHON_DIR)
	install  -D -m644 $(LIBV4L2_PYTHON_DIR)/pyv4l2.pyc \
		$(LIBV4L2_PYTHON_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/pyv4l2.pyc
	install  -D -m644 $(LIBV4L2_PYTHON_DIR)/libpyv4l2.so \
		$(LIBV4L2_PYTHON_PKGDIR)/usr/lib/libpyv4l2.so
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libv4l2-python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libv4l2-python)
	@$(call install_fixup, libv4l2-python,PRIORITY,optional)
	@$(call install_fixup, libv4l2-python,SECTION,base)
	@$(call install_fixup, libv4l2-python,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libv4l2-python,DESCRIPTION,missing)

	@$(call install_copy, libv4l2-python, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/pyv4l2.pyc)
	@$(call install_copy, libv4l2-python, 0, 0, 0644, -, \
		/usr/lib/libpyv4l2.so)

	@$(call install_finish, libv4l2-python)

	@$(call touch)

# vim: syntax=make

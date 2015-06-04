# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON_PROTOBUF) += python-protobuf

#
# Paths and names
#
PYTHON_PROTOBUF_VERSION	= $(PROTOBUF_VERSION)
PYTHON_PROTOBUF_MD5	= $(PROTOBUF_MD5)
PYTHON_PROTOBUF		= python-$(PROTOBUF)
PYTHON_PROTOBUF_SUFFIX	= $(PROTOBUF_SUFFIX)
PYTHON_PROTOBUF_URL	= $(PROTOBUF_URL)
PYTHON_PROTOBUF_SOURCE	= $(SRCDIR)/$(PROTOBUF).$(PYTHON_PROTOBUF_SUFFIX)
PYTHON_PROTOBUF_DIR	= $(BUILDDIR)/$(PYTHON_PROTOBUF)
PYTHON_PROTOBUF_SUBDIR	= python
PYTHON_PROTOBUF_LICENSE	= $(PROTOBUF_LICENSE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_PROTOBUF_CONF_TOOL	:= python

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-protobuf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-protobuf)
	@$(call install_fixup, python-protobuf,PRIORITY,optional)
	@$(call install_fixup, python-protobuf,SECTION,base)
	@$(call install_fixup, python-protobuf,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python-protobuf,DESCRIPTION,missing)

	@for file in `find $(PYTHON_PROTOBUF_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/google  \
			! -type d ! -name "*.py" -printf "%P\n"`; do \
		$(call install_copy, python-protobuf, 0, 0, 0644, -, \
			/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/google/$$file); \
	done
	@$(call install_copy, python-protobuf, 0, 0, 0644, -, \
			/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/protobuf-$(PYTHON_PROTOBUF_VERSION)-py$(PYTHON_MAJORMINOR)-nspkg.pth)

	@$(call install_finish, python-protobuf)

	@$(call touch)

# vim: syntax=make

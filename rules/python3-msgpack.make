# -*-makefile-*-
#
# Copyright (C) 2016 by Florian Scherf <f.scherf@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_MSGPACK) += python3-msgpack

#
# Paths and names
#
PYTHON3_MSGPACK_VERSION	:= 0.4.8
PYTHON3_MSGPACK_MD5	:= dcd854fb41ee7584ebbf35e049e6be98
PYTHON3_MSGPACK		:= msgpack-python-$(PYTHON3_MSGPACK_VERSION)
PYTHON3_MSGPACK_SUFFIX	:= tar.gz
PYTHON3_MSGPACK_URL	:= https://pypi.python.org/packages/21/27/8a1d82041c7a2a51fcc73675875a5f9ea06c2663e02fcfeb708be1d081a0/$(PYTHON3_MSGPACK).$(PYTHON3_MSGPACK_SUFFIX)\#md5=$(PYTHON3_MSGPACK_MD5)
PYTHON3_MSGPACK_SOURCE	:= $(SRCDIR)/$(PYTHON3_MSGPACK).$(PYTHON3_MSGPACK_SUFFIX)
PYTHON3_MSGPACK_DIR	:= $(BUILDDIR)/$(PYTHON3_MSGPACK)
PYTHON3_MSGPACK_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MSGPACK_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-msgpack.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-msgpack)
	@$(call install_fixup, python3-msgpack, PRIORITY, optional)
	@$(call install_fixup, python3-msgpack, SECTION, base)
	@$(call install_fixup, python3-msgpack, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-msgpack, DESCRIPTION, It`s like JSON. But fast and small.)

	@$(call install_glob, python3-msgpack, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/msgpack,, *.py)

	@$(call install_finish, python3-msgpack)

	@$(call touch)

# vim: syntax=make

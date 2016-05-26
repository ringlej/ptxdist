# -*-makefile-*-
#
# Copyright (C) 2015 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOHTTP_WSGI) += python3-aiohttp-wsgi

#
# Paths and names
#
PYTHON3_AIOHTTP_WSGI_VERSION	:= 0.2.5
PYTHON3_AIOHTTP_WSGI_MD5	:= ab630af7b72622a8f1534639cf48cd2d
PYTHON3_AIOHTTP_WSGI		:= aiohttp-wsgi-$(PYTHON3_AIOHTTP_WSGI_VERSION)
PYTHON3_AIOHTTP_WSGI_SUFFIX	:= tar.gz
PYTHON3_AIOHTTP_WSGI_URL	:= https://pypi.python.org/packages/source/a/aiohttp-wsgi/$(PYTHON3_AIOHTTP_WSGI).$(PYTHON3_AIOHTTP_WSGI_SUFFIX)
PYTHON3_AIOHTTP_WSGI_SOURCE	:= $(SRCDIR)/$(PYTHON3_AIOHTTP_WSGI).$(PYTHON3_AIOHTTP_WSGI_SUFFIX)
PYTHON3_AIOHTTP_WSGI_DIR	:= $(BUILDDIR)/$(PYTHON3_AIOHTTP_WSGI)
PYTHON3_AIOHTTP_WSGI_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOHTTP_WSGI_CONF_TOOL := python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON3_AIOHTTP_WSGI_PYTHON_PATH = /usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/aiohttp_wsgi

$(STATEDIR)/python3-aiohttp-wsgi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiohttp-wsgi)
	@$(call install_fixup, python3-aiohttp-wsgi, PRIORITY, optional)
	@$(call install_fixup, python3-aiohttp-wsgi, SECTION, base)
	@$(call install_fixup, python3-aiohttp-wsgi, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, python3-aiohttp-wsgi, DESCRIPTION, "WSGI adapter for aiohttp.")

	@$(call install_glob, python3-aiohttp-wsgi, 0, 0, -, \
		$(PYTHON3_AIOHTTP_WSGI_PYTHON_PATH),, *.py)

	@$(call install_finish, python3-aiohttp-wsgi)

	@$(call touch)

# vim: syntax=make

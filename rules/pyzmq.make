# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYZMQ) += pyzmq

#
# Paths and names
#
PYZMQ_VERSION	:= 14.1.0
PYZMQ_MD5	:= 174901a85e4574629d4e586b5d37acc4
PYZMQ		:= pyzmq-$(PYZMQ_VERSION)
PYZMQ_SUFFIX	:= tar.gz
PYZMQ_URL	:= https://pypi.python.org/packages/source/p/pyzmq/$(PYZMQ).$(PYZMQ_SUFFIX)
PYZMQ_SOURCE	:= $(SRCDIR)/$(PYZMQ).$(PYZMQ_SUFFIX)
PYZMQ_DIR	:= $(BUILDDIR)/$(PYZMQ)
PYZMQ_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYZMQ_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/pyzmq.compile:
	@$(call targetinfo)
	cd $(PYZMQ_DIR) && \
		$(CROSS_ENV) $(CROSS_PYTHON) \
		setup.py build --zmq=bundled
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pyzmq.install:
	@$(call targetinfo)
	@cd $(PYZMQ_DIR) && \
		$(CROSS_ENV) $(CROSS_PYTHON) \
		setup.py install --root=$(PYZMQ_PKGDIR) --prefix=/usr
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pyzmq.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pyzmq)
	@$(call install_fixup, pyzmq,PRIORITY,optional)
	@$(call install_fixup, pyzmq,SECTION,base)
	@$(call install_fixup, pyzmq,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, pyzmq,DESCRIPTION,missing)

	@for file in $(shell cd $(PYZMQ_PKGDIR) && find . -name "*.pyc"); \
		do \
		$(call install_copy, pyzmq, 0, 0, 0644, -, /$$file); \
	done

	@for file in $(shell cd $(PYZMQ_PKGDIR) && find . -name "*.so"); \
		do \
		$(call install_copy, pyzmq, 0, 0, 0755, -, /$$file); \
	done

	@$(call install_finish, pyzmq)

	@$(call touch)

# vim: syntax=make

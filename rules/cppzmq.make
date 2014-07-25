# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CPPZMQ) += cppzmq

#
# Paths and names
#
CPPZMQ_VERSION	:= ee47ae4cddc3
CPPZMQ_MD5	:= cf5d2f77caaa0749e522c143fd5260c8
CPPZMQ		:= cppzmq-$(CPPZMQ_VERSION)
CPPZMQ_SUFFIX	:= tar.gz
CPPZMQ_URL	:= https://github.com/zeromq/cppzmq.git;tag=$(CPPZMQ_VERSION)
CPPZMQ_SOURCE	:= $(SRCDIR)/$(CPPZMQ).$(CPPZMQ_SUFFIX)
CPPZMQ_DIR	:= $(BUILDDIR)/$(CPPZMQ)
CPPZMQ_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPPZMQ_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/cppzmq.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cppzmq.install:
	@$(call targetinfo)
	install -D -m 0644 $(CPPZMQ_DIR)/zmq.hpp $(CPPZMQ_PKGDIR)/usr/include/zmq.hpp
	@$(call touch)

# vim: syntax=make

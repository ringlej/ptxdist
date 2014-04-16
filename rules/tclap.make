# -*-makefile-*-
#
# Copyright (C) 2014 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCLAP) += tclap

#
# Paths and names
#
TCLAP_VERSION	:= 1.2.1
TCLAP_MD5	:= eb0521d029bf3b1cc0dcaa7e42abf82a
TCLAP		:= tclap-$(TCLAP_VERSION)
TCLAP_SUFFIX	:= tar.gz
TCLAP_URL	:= $(call ptx/mirror, SF, tclap/$(TCLAP).$(TCLAP_SUFFIX))
TCLAP_SOURCE	:= $(SRCDIR)/$(TCLAP).$(TCLAP_SUFFIX)
TCLAP_DIR	:= $(BUILDDIR)/$(TCLAP)
TCLAP_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TCLAP_CONF_TOOL	:= autoconf
TCLAP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen

# vim: syntax=make

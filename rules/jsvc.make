# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSVC) += jsvc

#
# Paths and names
#
JSVC		:= jsvc
JSVC_VERSION	:= none
JSVC_SUFFIX	:= tar.gz
JSVC_DIR	:= $(BUILDDIR)/$(JSVC)-src

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/jsvc.extract: $(STATEDIR)/tomcat.extract
	@$(call targetinfo)
	@$(call clean, $(JSVC_DIR))
	cd $(BUILDDIR) && tar xf $(TOMCAT_DIR)/bin/$(JSVC).$(JSVC_SUFFIX)
	chmod +x $(JSVC_DIR)/configure
	@$(call patchin, JSVC, $(JSVC_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JSVC_PATH	:= PATH=$(CROSS_PATH)
JSVC_ENV	:= $(CROSS_ENV)

#
# autoconf
#
JSVC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

# HACK: what we really need is a sun-java6-jdk and only install the jre stuff
ifdef PTXCONF_SUN_JAVA6_JRE
JSVC_AUTOCONF += --with-java=$(PTXCONF_SETUP_JAVA_SDK)
else
JSVC_AUTOCONF += --with-java=$(SYSROOT)/usr
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jsvc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jsvc.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  jsvc)
	@$(call install_fixup, jsvc,PACKAGE,jsvc)
	@$(call install_fixup, jsvc,PRIORITY,optional)
	@$(call install_fixup, jsvc,VERSION,$(JSVC_VERSION))
	@$(call install_fixup, jsvc,SECTION,base)
	@$(call install_fixup, jsvc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, jsvc,DEPENDS,)
	@$(call install_fixup, jsvc,DESCRIPTION,missing)

	@$(call install_copy, jsvc, 0, 0, 0755, $(JSVC_DIR)/jsvc, /usr/bin/jsvc)

	@$(call install_finish, jsvc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

jsvc_clean:
	rm -rf $(STATEDIR)/jsvc.*
	rm -rf $(PKGDIR)/jsvc_*
	rm -rf $(JSVC_DIR)

# vim: syntax=make

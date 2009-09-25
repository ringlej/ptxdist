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
PACKAGES-$(PTXCONF_TOMCAT) += tomcat

#
# Paths and names
#
TOMCAT_VERSION	:= 6.0.20
TOMCAT		:= apache-tomcat-$(TOMCAT_VERSION)
TOMCAT_SUFFIX	:= tar.gz
TOMCAT_URL	:= http://apache.lauf-forum.at/tomcat/tomcat-6/v6.0.20/bin/$(TOMCAT).$(TOMCAT_SUFFIX)
TOMCAT_SOURCE	:= $(SRCDIR)/$(TOMCAT).$(TOMCAT_SUFFIX)
TOMCAT_DIR	:= $(BUILDDIR)/$(TOMCAT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TOMCAT_SOURCE):
	@$(call targetinfo)
	@$(call get, TOMCAT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/tomcat.extract:
	@$(call targetinfo)
	@$(call clean, $(TOMCAT_DIR))
	@$(call extract, TOMCAT)
	@$(call patchin, TOMCAT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TOMCAT_PATH	:= PATH=$(CROSS_PATH)
TOMCAT_ENV 	:= $(CROSS_ENV)
TOMCAT_PREFIX	:= /usr/tomcat

$(STATEDIR)/tomcat.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/tomcat.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tomcat.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tomcat.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  tomcat)
	@$(call install_fixup, tomcat,PACKAGE,tomcat)
	@$(call install_fixup, tomcat,PRIORITY,optional)
	@$(call install_fixup, tomcat,VERSION,$(TOMCAT_VERSION))
	@$(call install_fixup, tomcat,SECTION,base)
	@$(call install_fixup, tomcat,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, tomcat,DEPENDS,)
	@$(call install_fixup, tomcat,DESCRIPTION,missing)

	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/bin)
	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/conf)
	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/lib)
	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/webapps)

	@cd $(TOMCAT_DIR) && for prog in bin/*.sh; do			\
		$(call install_copy, tomcat, 0, 0, 0755,		\
			$(TOMCAT_DIR)/$$prog,				\
			$(TOMCAT_PREFIX)/$$prog,n);			\
	done
	@cd $(TOMCAT_DIR) && for file in bin/*.jar conf/* lib/*; do	\
		$(call install_copy, tomcat, 0, 0, 0644,		\
			$(TOMCAT_DIR)/$$file,				\
			$(TOMCAT_PREFIX)/$$file,n);			\
	done

	@$(call install_finish, tomcat)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tomcat_clean:
	rm -rf $(STATEDIR)/tomcat.*
	rm -rf $(PKGDIR)/tomcat_*
	rm -rf $(TOMCAT_DIR)

# vim: syntax=make

# -*-makefile-*-
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
TOMCAT_VERSION	:= 5.0.30
TOMCAT		:= jakarta-tomcat-$(TOMCAT_VERSION)
TOMCAT_SUFFIX	:= tar.gz
TOMCAT_URL	:= http://archive.apache.org/dist/tomcat/tomcat-5/v5.0.30/bin/$(TOMCAT).$(TOMCAT_SUFFIX)
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
	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/common/lib)
	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/server/lib)
	@$(call install_copy, tomcat, 0, 0, 0755, $(TOMCAT_PREFIX)/webapps)
	@$(call install_copy, tomcat, 0, 0, 0755, /tmp/tomcat/work)
	@$(call install_copy, tomcat, 0, 0, 0755, /tmp/tomcat/temp)
	@$(call install_copy, tomcat, 0, 0, 0755, /tmp/tomcat/logs)
	@$(call install_link, tomcat, ../../tmp/tomcat/work, $(TOMCAT_PREFIX)/work)
	@$(call install_link, tomcat, ../../tmp/tomcat/temp, $(TOMCAT_PREFIX)/temp)
	@$(call install_link, tomcat, ../../tmp/tomcat/logs, $(TOMCAT_PREFIX)/logs)

	@cd $(TOMCAT_DIR) && for file in bin/*.jar common/lib/*.jar	\
				server/lib/*.jar; do			\
		$(call install_copy, tomcat, 0, 0, 0644,		\
			$(TOMCAT_DIR)/$$file,				\
			$(TOMCAT_PREFIX)/$$file,n);			\
	done
	@$(call install_copy, tomcat, 0, 0, 0644, \
		$(TOMCAT_DIR)/conf/web.xml, \
		$(TOMCAT_PREFIX)/conf/web.xml)
	@$(call install_copy, tomcat, 0, 0, 0644, \
		$(TOMCAT_DIR)/conf/server-minimal.xml, \
		$(TOMCAT_PREFIX)/conf/server.xml)

	@$(call install_alternative, tomcat, 0, 0, 0755, /etc/init.d/tomcat)

	@$(call install_finish, tomcat)

	@$(call touch)

# vim: syntax=make

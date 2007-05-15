# -*-makefile-*-
# $Id: template 5021 2006-03-05 11:13:02Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EVENTLOG) += eventlog

#
# Paths and names
#
EVENTLOG_VERSION	= 0.2.4
EVENTLOG		= eventlog-$(EVENTLOG_VERSION)
EVENTLOG_SUFFIX		= tar.gz
EVENTLOG_URL		= http://www.balabit.com/downloads/files/syslog-ng/1.9/src/$(EVENTLOG).$(EVENTLOG_SUFFIX)
EVENTLOG_SOURCE		= $(SRCDIR)/$(EVENTLOG).$(EVENTLOG_SUFFIX)
EVENTLOG_DIR		= $(BUILDDIR)/$(EVENTLOG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

eventlog_get: $(STATEDIR)/eventlog.get

$(STATEDIR)/eventlog.get: $(eventlog_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(EVENTLOG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, EVENTLOG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

eventlog_extract: $(STATEDIR)/eventlog.extract

$(STATEDIR)/eventlog.extract: $(eventlog_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(EVENTLOG_DIR))
	@$(call extract, EVENTLOG)
	@$(call patchin, EVENTLOG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

eventlog_prepare: $(STATEDIR)/eventlog.prepare

EVENTLOG_PATH	:=  PATH=$(CROSS_PATH)
EVENTLOG_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
EVENTLOG_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/eventlog.prepare: $(eventlog_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(EVENTLOG_DIR)/config.cache)
	cd $(EVENTLOG_DIR) && \
		$(EVENTLOG_PATH) $(EVENTLOG_ENV) \
		./configure $(EVENTLOG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

eventlog_compile: $(STATEDIR)/eventlog.compile

$(STATEDIR)/eventlog.compile: $(eventlog_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(EVENTLOG_DIR) && $(EVENTLOG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

eventlog_install: $(STATEDIR)/eventlog.install

$(STATEDIR)/eventlog.install: $(eventlog_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, EVENTLOG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

eventlog_targetinstall: $(STATEDIR)/eventlog.targetinstall

$(STATEDIR)/eventlog.targetinstall: $(eventlog_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, eventlog)
	@$(call install_fixup,eventlog,PACKAGE,eventlog)
	@$(call install_fixup,eventlog,PRIORITY,optional)
	@$(call install_fixup,eventlog,VERSION,$(EVENTLOG_VERSION))
	@$(call install_fixup,eventlog,SECTION,base)
	@$(call install_fixup,eventlog,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,eventlog,DEPENDS,)
	@$(call install_fixup,eventlog,DESCRIPTION,missing)

	@$(call install_copy, eventlog, 0, 0, 0644, \
		$(EVENTLOG_DIR)/src/.libs/libevtlog.so.0.0.0, \
		/usr/lib/libevtlog.so.0.0.0)

	@$(call install_link, eventlog, \
		libevtlog.so.0.0.0, \
		/usr/lib/libevtlog.so.0)

	@$(call install_link, eventlog, \
		libevtlog.so.0.0.0, \
		/usr/lib/libevtlog.so)

	@$(call install_finish,eventlog)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

eventlog_clean:
	rm -rf $(STATEDIR)/eventlog.*
	rm -rf $(IMAGEDIR)/eventlog_*
	rm -rf $(EVENTLOG_DIR)

# vim: syntax=make

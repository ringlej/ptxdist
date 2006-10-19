# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DBUS) += dbus

#
# Paths and names
#
DBUS_VERSION	:= 0.94
DBUS		:= dbus-$(DBUS_VERSION)
DBUS_SUFFIX	:= tar.gz
DBUS_URL	:= http://dbus.freedesktop.org/releases/dbus/$(DBUS).$(DBUS_SUFFIX)
DBUS_SOURCE	:= $(SRCDIR)/$(DBUS).$(DBUS_SUFFIX)
DBUS_DIR	:= $(BUILDDIR)/$(DBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dbus_get: $(STATEDIR)/dbus.get

$(STATEDIR)/dbus.get: $(dbus_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DBUS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DBUS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dbus_extract: $(STATEDIR)/dbus.extract

$(STATEDIR)/dbus.extract: $(dbus_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DBUS_DIR))
	@$(call extract, DBUS)
	@$(call patchin, DBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dbus_prepare: $(STATEDIR)/dbus.prepare

DBUS_PATH	:= PATH=$(CROSS_PATH)
DBUS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-abstract-sockets=yes

# doesn't work automatically in this case
dbus_prepare_deps =  $(dbus_prepare_deps_default)
ifdef PTXCONF_DBUS_XML_EXPAT
dbus_prepare_deps += $(STATEDIR)/expat.install
endif
ifdef PTXCONF_DBUS_XML_LIBXML2
dbus_prepare_deps += $(STATEDIR)/libxml2.install
endif

$(STATEDIR)/dbus.prepare: $(dbus_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DBUS_DIR)/config.cache)
	cd $(DBUS_DIR) && \
		$(DBUS_PATH) $(DBUS_ENV) \
		./configure $(DBUS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dbus_compile: $(STATEDIR)/dbus.compile

$(STATEDIR)/dbus.compile: $(dbus_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DBUS_DIR) && $(DBUS_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dbus_install: $(STATEDIR)/dbus.install

$(STATEDIR)/dbus.install: $(dbus_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dbus_targetinstall: $(STATEDIR)/dbus.targetinstall

dbus_targetinstall_deps =  $(dbus_targetinstall_deps_default)
ifdef PTXCONF_DBUS_XML_EXPAT
dbus_targetinstall_deps += $(STATEDIR)/expat.targetinstall
endif
ifdef PTXCONF_DBUS_XML_LIBXML2
dbus_targetinstall_deps += $(STATEDIR)/libxml2.targetinstall
endif

$(STATEDIR)/dbus.targetinstall: $(dbus_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init, dbus)
	@$(call install_fixup,dbus,PACKAGE,dbus)
	@$(call install_fixup,dbus,PRIORITY,optional)
	@$(call install_fixup,dbus,VERSION,$(DBUS_VERSION))
	@$(call install_fixup,dbus,SECTION,base)
	@$(call install_fixup,dbus,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,dbus,DEPENDS,)
	@$(call install_fixup,dbus,DESCRIPTION,missing)

	@$(call install_copy, dbus, 0, 0, 0644, \
		$(DBUS_DIR)/dbus/.libs/libdbus-1.so.3.2.0, \
		/usr/lib/libdbus-1.so.3.2.0)
	@$(call install_link, dbus, libdbus-1.so.3.2.0, /usr/lib/libdbos-1.so.3)
	@$(call install_link, dbus, libdbus-1.so.3.2.0, /usr/lib/libdbos-1.so)

	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-send, \
		/usr/bin/dbus-send)

	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-launch, \
		/usr/bin/dbus-launch)

	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-cleanup-sockets, \
		/usr/bin/dbus-cleanup-sockets)

	@$(call install_copy, dbus, 0, 0, 0755, \
		$(DBUS_DIR)/tools/dbus-uuidgen, \
		/usr/bin/dbus-uuidgen)

	@$(call install_finish,dbus)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbus_clean:
	rm -rf $(STATEDIR)/dbus.*
	rm -rf $(IMAGEDIR)/dbus_*
	rm -rf $(DBUS_DIR)

# vim: syntax=make

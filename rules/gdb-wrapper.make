# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: what's the purpose of that? 

#
# We provide this package
#
PACKAGES-$(PTXCONF_GDB_WRAPPER) += gdb-wrapper


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdb-wrapper_get: $(STATEDIR)/gdb-wrapper.get

$(STATEDIR)/gdb-wrapper.get: $(gdb_wrapper_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdb-wrapper_extract: $(STATEDIR)/gdb-wrapper.extract

$(STATEDIR)/gdb-wrapper.extract: $(gdb_wrapper_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdb-wrapper_prepare: $(STATEDIR)/gdb-wrapper.prepare

$(STATEDIR)/gdb-wrapper.prepare: $(gdb_wrapper_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdb-wrapper_compile: $(STATEDIR)/gdb-wrapper.compile

$(STATEDIR)/gdb-wrapper.compile: $(gdb_wrapper_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdb-wrapper_install: $(STATEDIR)/gdb-wrapper.install

$(STATEDIR)/gdb-wrapper.install: $(gdb_wrapper_install_deps_default)
	@$(call targetinfo, $@)

	# let gdb find the target libraries for remote cross debugging
	install -d $(PTXCONF_SYSROOT_TARGET)/etc
	rm -f $(PTXCONF_SYSROOT_TARGET)/etc/gdbrc
	echo "set solib-search-path $(ROOTDIR)/lib:$(ROOTDIR)/usr/lib" >> $(PTXCONF_SYSROOT_TARGET)/etc/gdbrc
	echo "set solib-absolute-prefix $(ROOTDIR)" >> $(PTXCONF_SYSROOT_TARGET)/etc/gdbrc

	# make gdb wrapper
	install -d $(PTXCONF_SYSROOT_TARGET)/bin
	rm -f $(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossgdb
	echo "#!/bin/sh" >> \
		$(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossgdb
	echo "$(PTXCONF_GNU_TARGET)-gdb -x $(PTXCONF_SYSROOT_TARGET)/etc/gdbrc \$$@" >> \
		$(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossgdb
	chmod 755 $(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossgdb

	# make ddd wrapper
	rm -f $(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossddd
	echo "#!/bin/sh" >> \
		$(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossddd
	echo "ddd --debugger $(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossgdb \$$@" >> \
		$(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossddd
	chmod 755 $(PTXCONF_SYSROOT_TARGET)/bin/$(PTXCONF_GNU_TARGET)-crossddd

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdb-wrapper_targetinstall: $(gdb_wrapper_targetinstall_defaults)

$(STATEDIR)/gdb-wrapper.targetinstall: $(STATEDIR)/gdb-wrapper.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb-wrapper_clean: 
	rm -rf $(STATEDIR)/gdb-wrapper.* $(GDB_DIR)

# vim: syntax=make

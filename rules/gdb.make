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

#
# We provide this package
#
PACKAGES-$(PTXCONF_GDB) += gdb

#
# Paths and names 
#
GDB_VERSION	= 6.6
GDB		= gdb-$(GDB_VERSION)
GDB_SUFFIX	= tar.bz2
GDB_URL		= $(PTXCONF_SETUP_GNUMIRROR)/gdb/$(GDB).$(GDB_SUFFIX)
GDB_SOURCE	= $(SRCDIR)/$(GDB).$(GDB_SUFFIX)
GDB_DIR		= $(BUILDDIR)/$(GDB)
GDB_BUILDDIR	= $(BUILDDIR)/$(GDB)-build


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdb_get: $(STATEDIR)/gdb.get

$(STATEDIR)/gdb.get: $(gdb_get_deps_default) $(GDB_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GDB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GDB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdb_extract: $(STATEDIR)/gdb.extract

$(STATEDIR)/gdb.extract: $(gdb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_DIR))
	@$(call extract, GDB)
	@$(call patchin, GDB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdb_prepare: $(STATEDIR)/gdb.prepare

GDB_PATH	=  PATH=$(CROSS_PATH)

GDB_ENV_AC	= \
	$(CROSS_ENV_AC) \
	gdb_cv_func_sigsetjmp=yes \
	bash_cv_func_strcoll_broken=no \
	bash_cv_must_reinstall_sighandlers=no \
	bash_cv_func_sigsetjmp=present \
	bash_cv_have_mbstate_t=yes

GDB_ENV		= \
	$(CROSS_ENV) \
	$(CROSS_ENV_FLAGS_FOR_TARGET) \
	$(GDB_ENV_AC) \
	CFLAGS='$(strip $(CROSS_CFLAGS)) $(strip $(CROSS_CPPFLAGS))' \
	CFLAGS_FOR_TARGET='$(strip $(CROSS_CFLAGS)) $(strip $(CROSS_CPPFLAGS))'

ifndef PTXCONF_GDB_SHARED
GDB_MAKEVARS	=  LDFLAGS=-static
endif

#
# autoconf
#
GDB_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--target=$(call remove_quotes,$(PTXCONF_GNU_TARGET)) \
	--enable-serial-configure \
	--with-build-sysroot=$(SYSROOT)

$(STATEDIR)/gdb.prepare: $(gdb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_BUILDDIR))
	mkdir -p $(GDB_BUILDDIR)
	cd $(GDB_BUILDDIR) && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/configure $(GDB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdb_compile: $(STATEDIR)/gdb.compile

$(STATEDIR)/gdb.compile: $(gdb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GDB_BUILDDIR) && $(GDB_PATH) $(GDB_ENV_AC) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdb_install: $(STATEDIR)/gdb.install

$(STATEDIR)/gdb.install: $(gdb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdb_targetinstall: $(STATEDIR)/gdb.targetinstall

$(STATEDIR)/gdb.targetinstall: $(gdb_targetinstall_deps_default)
	@$(call targetinfo, $@)

	mkdir -p $(ROOTDIR)/usr/bin

	@$(call install_init, gdb)
	@$(call install_fixup, gdb,PACKAGE,gdb)
	@$(call install_fixup, gdb,PRIORITY,optional)
	@$(call install_fixup, gdb,VERSION,$(GDB_VERSION))
	@$(call install_fixup, gdb,SECTION,base)
	@$(call install_fixup, gdb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gdb,DEPENDS,)
	@$(call install_fixup, gdb,DESCRIPTION,missing)

	@$(call install_copy, gdb, 0, 0, 0755, $(GDB_BUILDDIR)/gdb/gdb, /usr/bin/gdb)

	@$(call install_finish, gdb)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb_clean: 
	rm -rf $(STATEDIR)/gdb.* $(GDB_DIR)
	rm -rf $(IMAGEDIR)/gdb_*

# vim: syntax=make

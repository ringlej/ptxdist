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
ifdef PTXCONF_GDB
PACKAGES += gdb
endif

#
# Paths and names 
#
GDB_VERSION	= 6.3
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

gdb_get_deps = $(GDB_SOURCE)

$(STATEDIR)/gdb.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GDB))
	touch $@

$(GDB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GDB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdb_extract: $(STATEDIR)/gdb.extract

$(STATEDIR)/gdb.extract: $(STATEDIR)/gdb.get
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_DIR))
	@$(call extract, $(GDB_SOURCE))
	@$(call patchin, $(GDB))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdb_prepare: $(STATEDIR)/gdb.prepare

#
# dependencies
#
gdb_prepare_deps =  $(STATEDIR)/virtual-xchain.install
gdb_prepare_deps += $(STATEDIR)/gdb.extract

ifdef PTXCONF_GDB_TERMCAP
gdb_prepare_deps += $(STATEDIR)/termcap.install
endif
ifdef PTXCONF_GDB_NCURSES
gdb_prepare_deps += $(STATEDIR)/ncurses.install
endif

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
	$(CROSS_AUTOCONF) \
	--target=$(call remove_quotes,$(PTXCONF_GNU_TARGET)) \
	--enable-serial-configure \
	--prefix=/usr

$(STATEDIR)/gdb.prepare: $(gdb_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_BUILDDIR))
	mkdir -p $(GDB_BUILDDIR)
	cd $(GDB_BUILDDIR) && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/configure $(GDB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdb_compile: $(STATEDIR)/gdb.compile

$(STATEDIR)/gdb.compile: $(STATEDIR)/gdb.prepare 
	@$(call targetinfo, $@)
	cd $(GDB_BUILDDIR) && $(GDB_PATH) $(GDB_ENV_AC) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdb_install: $(STATEDIR)/gdb.install

$(STATEDIR)/gdb.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdb_targetinstall: $(STATEDIR)/gdb.targetinstall

gdb_targetinstall_deps = \
	$(STATEDIR)/gdb.compile

$(STATEDIR)/gdb.targetinstall: $(gdb_targetinstall_deps)
	@$(call targetinfo, $@)

	mkdir -p $(ROOTDIR)/usr/bin

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gdb)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GDB_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(GDB_BUILDDIR)/gdb/gdb, /usr/bin/gdb)

	@$(call install_finish)

	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/gdb
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb_clean: 
	rm -rf $(STATEDIR)/gdb.* $(GDB_DIR)
	rm -rf $(IMAGEDIR)/gdb_*

# vim: syntax=make

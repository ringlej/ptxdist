# -*-makefile-*-
# $Id: ncurses.make,v 1.7 2003/08/27 18:54:31 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
# FIXME: this is currently not integrated into PTXCONF
ifeq (y, $(PTXCONF_NCURSES))
PACKAGES += ncurses
endif

#
# Paths and names 
#
NCURSES_VERSION			= 5.3
NCURSES				= ncurses-$(NCURSES_VERSION)
NCURSES_SUFFIX			= tar.gz
NCURSES_URL			= ftp://ftp.gnu.org/pub/gnu/ncurses/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_SOURCE			= $(SRCDIR)/$(NCURSES).$(NCURSES_SUFFIX)
NCURSES_DIR			= $(BUILDDIR)/$(NCURSES)

# Arrgh.  Huge patch.  Required to cross-compile.
NCURSES_PATCH			= ncurses-5.3-20030719-patch.sh.bz2
NCURSES_PATCH_URL		= ftp://invisible-island.net/ncurses/5.3/$(NCURSES_PATCH)
NCURSES_PATCH_SOURCE		= $(SRCDIR)/$(NCURSES_PATCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ncurses_get: $(STATEDIR)/ncurses.get

$(STATEDIR)/ncurses.get: $(NCURSES_SOURCE) $(NCURSES_PATCH_SOURCE)
	@$(call targetinfo, ncurses.get)
	touch $@

$(NCURSES_SOURCE):
	@$(call targetinfo, $(NCURSES_SOURCE))
	@$(call get, $(NCURSES_URL))

$(NCURSES_PATCH_SOURCE):
	@$(call targetinfo, $(NCURSES_PATCH))
	@$(call get, $(NCURSES_PATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ncurses_extract: $(STATEDIR)/ncurses.extract

$(STATEDIR)/ncurses.extract: $(STATEDIR)/ncurses.get
	@$(call targetinfo, ncurses.extract)
	@$(call clean, $(NCURSES_DIR))
	@$(call extract, $(NCURSES_SOURCE))
	@$(call patchin, $(NCURSES_DIR), $(NCURSES)) 
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ncurses_prepare: $(STATEDIR)/ncurses.prepare

#
# dependencies
#
ncurses_prepare_deps =  \
	$(STATEDIR)/ncurses.extract \
	$(STATEDIR)/virtual-xchain.install

NCURSES_PATH		=  PATH=$(CROSS_PATH)
NCURSES_ENV 		=  $(CROSS_ENV)
NCURSES_MAKEVARS	=  HOSTCC=$(HOSTCC)

NCURSES_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)
NCURSES_AUTOCONF	+= --build=$(GNU_HOST)
NCURSES_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
NCURSES_AUTOCONF	+= --with-shared
ifdef PTXCONF_GCC_3_2_3
NCURSES_AUTOCONF	+= --without-cxx
endif

$(STATEDIR)/ncurses.prepare: $(ncurses_prepare_deps)
	@$(call targetinfo, ncurses.prepare)
	cd $(NCURSES_DIR) && \
		$(NCURSES_PATH) $(NCURSES_ENV) \
		./configure $(NCURSES_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ncurses_compile: $(STATEDIR)/ncurses.compile

$(STATEDIR)/ncurses.compile: $(STATEDIR)/ncurses.prepare 
	@$(call targetinfo, ncurses.compile)
	$(NCURSES_PATH) $(NCURSES_ENV) make -C $(NCURSES_DIR) $(NCURSES_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ncurses_install: $(STATEDIR)/ncurses.install

$(STATEDIR)/ncurses.install: $(STATEDIR)/ncurses.compile
	@$(call targetinfo, ncurses.install)
# 	$(NCURSES_PATH) make -C $(NCURSES_DIR) install
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	install $(NCURSES_DIR)/lib/libncurses.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libncurses.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libncurses.so.5
	ln -sf libncurses.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libncurses.so
	install $(NCURSES_DIR)/lib/libform.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libform.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libform.so.5
	ln -sf libform.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libform.so
	install $(NCURSES_DIR)/lib/libmenu.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libmenu.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libmenu.so.5
	ln -sf libmenu.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libmenu.so
	install $(NCURSES_DIR)/lib/libpanel.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libpanel.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpanel.so.5
	ln -sf libpanel.so.5.3 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpanel.so
	install $(NCURSES_DIR)/include/curses.h $(PTXCONF_PREFIX)/include/
	ln -sf curses.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/ncurses.h
	install $(NCURSES_DIR)/include/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ncurses_targetinstall: $(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/ncurses.targetinstall: $(STATEDIR)/ncurses.install
	@$(call targetinfo, ncurses.targetinstall)
	# FIXME: make configurable which libraries are installed!
	install -d $(ROOTDIR)/lib
	install $(NCURSES_DIR)/lib/libncurses.so.5.3 $(ROOTDIR)/lib
	ln -sf libncurses.so.5.3 $(ROOTDIR)/lib/libncurses.so.5
	ln -sf libncurses.so.5.3 $(ROOTDIR)/lib/libncurses.so
	install $(NCURSES_DIR)/lib/libform.so.5.3 $(ROOTDIR)/lib
	ln -sf libform.so.5.3 $(ROOTDIR)/lib/libform.so.5
	ln -sf libform.so.5.3 $(ROOTDIR)/lib/libform.so
	install $(NCURSES_DIR)/lib/libmenu.so.5.3 $(ROOTDIR)/lib
	ln -sf libmenu.so.5.3 $(ROOTDIR)/lib/libmenu.so.5
	ln -sf libmenu.so.5.3 $(ROOTDIR)/lib/libmenu.so
	install $(NCURSES_DIR)/lib/libpanel.so.5.3 $(ROOTDIR)/lib
	ln -sf libpanel.so.5.3 $(ROOTDIR)/lib/libpanel.so.5
	ln -sf libpanel.so.5.3 $(ROOTDIR)/lib/libpanel.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean: 
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)

# vim: syntax=make

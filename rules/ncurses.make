# -*-makefile-*-
# $Id: ncurses.make,v 1.5 2003/08/17 00:32:04 robert Exp $
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
NCURSES				= ncurses-5.2
NCURSES_URL			= ftp://ftp.gnu.org/pub/gnu/ncurses/$(NCURSES).tar.gz
NCURSES_SOURCE			= $(SRCDIR)/$(NCURSES).tar.gz
NCURSES_DIR			= $(BUILDDIR)/$(NCURSES)
NCURSES_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ncurses_get: $(STATEDIR)/ncurses.get

$(STATEDIR)/ncurses.get: $(NCURSES_SOURCE)
	@$(call targetinfo, ncurses.get)
	touch $@

$(NCURSES_SOURCE):
	@$(call targetinfo, $(NCURSES_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(NCURSES_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ncurses_extract: $(STATEDIR)/ncurses.extract

$(STATEDIR)/ncurses.extract: $(STATEDIR)/ncurses.get
	@$(call targetinfo, ncurses.extract)
	$(NCURSES_EXTRACT) $(NCURSES_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ncurses_prepare: $(STATEDIR)/ncurses.prepare

# FIXME: this has to be filled...
NCURSES_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)
NCURSES_AUTOCONF	+= --with-shared --target=$(PTXCONF_GNU_TARGET)
NCURSES_ENVIRONMENT	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
NCURSES_MAKEVARS	=  AR=$(PTXCONF_GNU_TARGET)-ar
NCURSES_MAKEVARS	+= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
NCURSES_MAKEVARS	+= CC=$(PTXCONF_GNU_TARGET)-gcc
NCURSES_MAKEVARS	+= CXX=$(PTXCONF_GNU_TARGET)-g++
#
#


# FIXME: gcc stage2 is just a workaround here:
$(STATEDIR)/ncurses.prepare: $(STATEDIR)/xchain-gccstage2.install $(STATEDIR)/ncurses.extract
	@$(call targetinfo, ncurses.prepare)
	cd $(NCURSES_DIR) && ./configure $(NCURSES_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ncurses_compile: $(STATEDIR)/ncurses.compile

$(STATEDIR)/ncurses.compile: $(STATEDIR)/ncurses.prepare 
	@$(call targetinfo, ncurses.compile)
	cd $(NCURSES_DIR) && $(NCURSES_ENVIRONMENT) make $(NCURSES_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ncurses_install: $(STATEDIR)/ncurses.install

$(STATEDIR)/ncurses.install: $(STATEDIR)/ncurses.compile
	@$(call targetinfo, ncurses.install)
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	install $(NCURSES_DIR)/lib/libncurses.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libncurses.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libncurses.so.5
	ln -sf libncurses.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libncurses.so
	install $(NCURSES_DIR)/lib/libform.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libform.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libform.so.5
	ln -sf libform.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libform.so
	install $(NCURSES_DIR)/lib/libmenu.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libmenu.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libmenu.so.5
	ln -sf libmenu.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libmenu.so
	install $(NCURSES_DIR)/lib/libpanel.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libpanel.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpanel.so.5
	ln -sf libpanel.so.5.2 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpanel.so
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
	install $(NCURSES_DIR)/lib/libncurses.so.5.2 $(ROOTDIR)/lib
	ln -sf libncurses.so.5.2 $(ROOTDIR)/lib/libncurses.so.5
	ln -sf libncurses.so.5.2 $(ROOTDIR)/lib/libncurses.so
	install $(NCURSES_DIR)/lib/libform.so.5.2 $(ROOTDIR)/lib
	ln -sf libform.so.5.2 $(ROOTDIR)/lib/libform.so.5
	ln -sf libform.so.5.2 $(ROOTDIR)/lib/libform.so
	install $(NCURSES_DIR)/lib/libmenu.so.5.2 $(ROOTDIR)/lib
	ln -sf libmenu.so.5.2 $(ROOTDIR)/lib/libmenu.so.5
	ln -sf libmenu.so.5.2 $(ROOTDIR)/lib/libmenu.so
	install $(NCURSES_DIR)/lib/libpanel.so.5.2 $(ROOTDIR)/lib
	ln -sf libpanel.so.5.2 $(ROOTDIR)/lib/libpanel.so.5
	ln -sf libpanel.so.5.2 $(ROOTDIR)/lib/libpanel.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean: 
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)

# vim: syntax=make

# $Id: ncurses.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
	touch $@

$(NCURSES_SOURCE):
	@echo
	@echo ----------- 
	@echo target: ncurses.get
	@echo -----------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(NCURSES_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ncurses_extract: $(STATEDIR)/ncurses.extract

$(STATEDIR)/ncurses.extract: $(STATEDIR)/ncurses.get
	@echo
	@echo --------------- 
	@echo target: ncurses.extract
	@echo ---------------
	@echo
	$(NCURSES_EXTRACT) $(NCURSES_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ncurses_prepare: $(STATEDIR)/ncurses.prepare

# FIXME: this has to be filled...
NCURSES_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)
NCURSES_AUTOCONF	+= --with-shared
NCURSES_ENVIRONMENT	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
NCURSES_MAKEVARS	=  AR=$(PTXCONF_GNU_TARGET)-ar
NCURSES_MAKEVARS	+= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
NCURSES_MAKEVARS	+= CC=$(PTXCONF_GNU_TARGET)-gcc
#
#


$(STATEDIR)/ncurses.prepare: $(STATEDIR)/ncurses.extract
	@echo
	@echo --------------- 
	@echo target: ncurses.prepare
	@echo ---------------
	@echo
	cd $(NCURSES_DIR) && ./configure $(NCURSES_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ncurses_compile: $(STATEDIR)/ncurses.compile

$(STATEDIR)/ncurses.compile: $(STATEDIR)/ncurses.prepare 
	@echo
	@echo --------------- 
	@echo target: ncurses.compile
	@echo ---------------
	@echo
	cd $(NCURSES_DIR) && $(NCURSES_ENVIRONMENT) make $(NCURSES_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ncurses_install: $(STATEDIR)/ncurses.install

$(STATEDIR)/ncurses.install: $(STATEDIR)/ncurses.compile
	@echo
	@echo --------------- 
	@echo target: ncurses.install
	@echo ---------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ncurses_targetinstall: $(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/ncurses.targetinstall: $(STATEDIR)/ncurses.install
	@echo
	@echo --------------------- 
	@echo target: ncurses.targetinstall
	@echo ---------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ncurses_clean: 
	rm -rf $(STATEDIR)/ncurses.* $(NCURSES_DIR)

# vim: syntax=make

# $Id: nettle.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
ifeq (y,$(PTXCONF_NETTLE))
PACKAGES += nettle
endif

#
# Paths and names 
#
NETTLE			= nettle-1.5
NETTLE_URL		= http://www.lysator.liu.se/~nisse/archive/$(NETTLE).tar.gz
NETTLE_SOURCE		= $(SRCDIR)/$(NETTLE).tar.gz
NETTLE_DIR		= $(BUILDDIR)/$(NETTLE)
NETTLE_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

nettle_get: $(STATEDIR)/nettle.get

$(STATEDIR)/nettle.get: $(NETTLE_SOURCE)
	touch $@

$(NETTLE_SOURCE):
	@echo
	@echo ----------
	@echo target: nettle.get
	@echo ----------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(NETTLE_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nettle_extract: $(STATEDIR)/nettle.extract

$(STATEDIR)/nettle.extract: $(STATEDIR)/nettle.get
	@echo
	@echo --------------
	@echo target: nettle.extract
	@echo --------------
	@echo
	$(NETTLE_EXTRACT) $(NETTLE_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nettle_prepare: $(STATEDIR)/nettle.prepare

NETTLE_AUTOCONF =
NETTLE_AUTOCONF += --build=i686-linux
NETTLE_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
NETTLE_AUTOCONF += --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/nettle.prepare: $(STATEDIR)/nettle.extract
	@echo
	@echo -------------- 
	@echo target: nettle.prepare
	@echo --------------
	@echo
	cd $(NETTLE_DIR) &&						\
		PATH=$(PTXCONF_PREFIX)/bin:$$PATH ./configure $(NETTLE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nettle_compile: $(STATEDIR)/nettle.compile

$(STATEDIR)/nettle.compile: $(STATEDIR)/nettle.prepare 
	@echo
	@echo -------------- 
	@echo target: nettle.compile
	@echo --------------
	@echo
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(NETTLE_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nettle_install: $(STATEDIR)/nettle.install

$(STATEDIR)/nettle.install: $(STATEDIR)/nettle.compile
	@echo
	@echo -------------- 
	@echo target: nettle.install
	@echo --------------
	@echo
	# FIXME: this doesn't work when using local bin directory...?
	make -C $(NETTLE_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nettle_targetinstall: $(STATEDIR)/nettle.targetinstall

$(STATEDIR)/nettle.targetinstall: $(STATEDIR)/nettle.install
	@echo
	@echo -------------------- 
	@echo target: nettle.targetinstall
	@echo --------------------
	@echo
	# nettle is only static at the moment
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nettle_clean: 
	rm -rf $(STATEDIR)/nettle.* $(NETTLE_DIR)

# vim: syntax=make

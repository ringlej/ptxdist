# $Id: nettle.make,v 1.3 2003/06/25 12:12:31 robert Exp $
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
	@$(call targetinfo, nettle.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(NETTLE_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

nettle_extract: $(STATEDIR)/nettle.extract

$(STATEDIR)/nettle.extract: $(STATEDIR)/nettle.get
	@$(call targetinfo, nettle.extract)
	$(NETTLE_EXTRACT) $(NETTLE_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

nettle_prepare: $(STATEDIR)/nettle.prepare

NETTLE_AUTOCONF =
NETTLE_AUTOCONF += --build=$(GNU_HOST)
NETTLE_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
NETTLE_AUTOCONF += --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/nettle.prepare: $(STATEDIR)/nettle.extract
	@$(call targetinfo, nettle.prepare)
	cd $(NETTLE_DIR) &&						\
		PATH=$(PTXCONF_PREFIX)/bin:$$PATH ./configure $(NETTLE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

nettle_compile: $(STATEDIR)/nettle.compile

$(STATEDIR)/nettle.compile: $(STATEDIR)/nettle.prepare 
	@$(call targetinfo, nettle.compile)
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(NETTLE_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

nettle_install: $(STATEDIR)/nettle.install

$(STATEDIR)/nettle.install: $(STATEDIR)/nettle.compile
	@$(call targetinfo, nettle.install)
	# FIXME: this doesn't work when using local bin directory...?
	make -C $(NETTLE_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

nettle_targetinstall: $(STATEDIR)/nettle.targetinstall

$(STATEDIR)/nettle.targetinstall: $(STATEDIR)/nettle.install
	@$(call targetinfo, nettle.targetinstall)
	# nettle is only static at the moment
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nettle_clean: 
	rm -rf $(STATEDIR)/nettle.* $(NETTLE_DIR)

# vim: syntax=make

# $Id: autoconf-2.13.make,v 1.2 2003/06/16 12:05:16 bsp Exp $
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
PACKAGES += autoconf213

#
# Paths and names 
#
AUTOCONF213			= autoconf-2.13
AUTOCONF213_URL			= ftp://ftp.gnu.org/pub/gnu/autoconf/$(AUTOCONF213).tar.gz
AUTOCONF213_SOURCE		= $(SRCDIR)/$(AUTOCONF213).tar.gz
AUTOCONF213_DIR			= $(BUILDDIR)/$(AUTOCONF213)
AUTOCONF213_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

autoconf213_get: $(STATEDIR)/autoconf213.get

$(STATEDIR)/autoconf213.get: $(AUTOCONF213_SOURCE)
	@$(call targetinfo, autoconf213.get)
	touch $@

$(AUTOCONF213_SOURCE):
	wget -P $(SRCDIR) $(PASSIVEFTP) $(AUTOCONF213_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

autoconf213_extract: $(STATEDIR)/autoconf213.extract

$(STATEDIR)/autoconf213.extract: $(STATEDIR)/autoconf213.get
	@$(call targetinfo, autoconf213.extract)
	$(AUTOCONF213_EXTRACT) $(AUTOCONF213_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

autoconf213_prepare: $(STATEDIR)/autoconf213.prepare

$(STATEDIR)/autoconf213.prepare: $(STATEDIR)/autoconf213.extract
	@$(call targetinfo, autoconf213.prepare)
	cd $(AUTOCONF213_DIR) && 					\
	CFLAGS=$(CFLAGS) ./configure --prefix=$(PTXCONF_PREFIX)/$(AUTOCONF213)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

autoconf213_compile: $(STATEDIR)/autoconf213.compile

$(STATEDIR)/autoconf213.compile: $(STATEDIR)/autoconf213.prepare 
	@$(call targetinfo, autoconf213.compile)
	make -C $(AUTOCONF213_DIR) $(MAKEPARMS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

autoconf213_install: $(STATEDIR)/autoconf213.install

$(STATEDIR)/autoconf213.install: $(STATEDIR)/autoconf213.compile
	@$(call targetinfo, autoconf213.install)
	make -C $(AUTOCONF213_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

autoconf213_targetinstall: $(STATEDIR)/autoconf213.targetinstall

$(STATEDIR)/autoconf213.targetinstall: $(STATEDIR)/autoconf213.install
	@$(call targetinfo, autoconf213.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

autoconf213_clean: 
	rm -rf $(STATEDIR)/autoconf213.* $(AUTOCONF213_DIR)

# vim: syntax=make

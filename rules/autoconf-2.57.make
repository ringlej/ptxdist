# $Id: autoconf-2.57.make,v 1.1 2003/04/24 08:06:33 jst Exp $
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
PACKAGES += autoconf257

#
# Paths and names 
#
AUTOCONF257			= autoconf-2.57
AUTOCONF257_URL			= ftp://ftp.gnu.org/pub/gnu/autoconf/$(AUTOCONF257).tar.gz
AUTOCONF257_SOURCE		= $(SRCDIR)/$(AUTOCONF257).tar.gz
AUTOCONF257_DIR			= $(BUILDDIR)/$(AUTOCONF257)
AUTOCONF257_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

autoconf257_get: $(STATEDIR)/autoconf257.get

$(STATEDIR)/autoconf257.get: $(AUTOCONF257_SOURCE)
	touch $@

$(AUTOCONF257_SOURCE):
	@echo
	@echo ----------------------- 
	@echo target: autoconf257.get
	@echo -----------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(AUTOCONF257_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

autoconf257_extract: $(STATEDIR)/autoconf257.extract

$(STATEDIR)/autoconf257.extract: $(STATEDIR)/autoconf257.get
	@echo
	@echo --------------------------- 
	@echo target: autoconf257.extract
	@echo ---------------------------
	@echo
	$(AUTOCONF257_EXTRACT) $(AUTOCONF257_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

autoconf257_prepare: $(STATEDIR)/autoconf257.prepare

$(STATEDIR)/autoconf257.prepare: $(STATEDIR)/autoconf257.extract
	@echo
	@echo --------------------------- 
	@echo target: autoconf257.prepare
	@echo ---------------------------
	@echo
	cd $(AUTOCONF257_DIR) && 					\
	CFLAGS=$(CFLAGS) ./configure --prefix=$(PTXCONF_PREFIX)/$(AUTOCONF257)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

autoconf257_compile: $(STATEDIR)/autoconf257.compile

$(STATEDIR)/autoconf257.compile: $(STATEDIR)/autoconf257.prepare 
	@echo
	@echo ---------------------------
	@echo target: autoconf257.compile
	@echo ---------------------------
	@echo
	make -C $(AUTOCONF257_DIR) $(MAKEPARMS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

autoconf257_install: $(STATEDIR)/autoconf257.install

$(STATEDIR)/autoconf257.install: $(STATEDIR)/autoconf257.compile
	@echo
	@echo ---------------------------
	@echo target: autoconf257.install
	@echo ---------------------------
	@echo
	make -C $(AUTOCONF257_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

autoconf257_targetinstall: $(STATEDIR)/autoconf257.targetinstall

$(STATEDIR)/autoconf257.targetinstall: $(STATEDIR)/autoconf257.install
	@echo
	@echo ---------------------------------
	@echo target: autoconf257.targetinstall
	@echo ---------------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

autoconf257_clean: 
	rm -rf $(STATEDIR)/autoconf257.* $(AUTOCONF257_DIR)

# vim: syntax=make

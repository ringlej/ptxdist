# -*-makefile-*-
# $Id: liboop.make,v 1.4 2003/07/16 04:23:28 mkl Exp $
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
ifeq (y,$(PTXCONF_LIBOOP))
PACKAGES += liboop
endif

#
# Paths and names 
#
LIBOOP			= liboop-0.8
LIBOOP_URL 		= http://download.ofb.net/liboop/$(LIBOOP).tar.gz
LIBOOP_SOURCE		= $(SRCDIR)/$(LIBOOP).tar.gz
LIBOOP_DIR 		= $(BUILDDIR)/$(LIBOOP)
LIBOOP_EXTRACT		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liboop_get: $(STATEDIR)/liboop.get

$(STATEDIR)/liboop.get: $(LIBOOP_SOURCE)
	@$(call targetinfo, liboop.get)
	touch $@

$(LIBOOP_SOURCE):
	@$(call targetinfo, $(LIBOOP_SOURCES))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(LIBOOP_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liboop_extract: $(STATEDIR)/liboop.extract

LIBOOP_USE_LIBTOOLIZE = libtoolize
LIBOOP_USE_ACLOCAL    = aclocal
LIBOOP_USE_AUTOCONF   = autoconf
LIBOOP_USE_AUTOMAKE   = automake

$(STATEDIR)/liboop.extract: $(STATEDIR)/liboop.get
	@$(call targetinfo, liboop.extract)
	$(LIBOOP_EXTRACT) $(LIBOOP_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	# 
	# we have to add a switch to disable tcl
	#
	#
	cd $(LIBOOP_DIR) && cat $(SRCDIR)/liboop-0.8-ptx1.diff | patch -p1
	rm -f $(LIBOOP_DIR)/missing
	rm -f $(LIBOOP_DIR)/libtool
	rm -f $(LIBOOP_DIR)/ltconfig
	rm -f $(LIBOOP_DIR)/ltmain.sh
	#
	cd $(LIBOOP_DIR) && $(LIBOOP_USE_LIBTOOLIZE) --force -c
	cd $(LIBOOP_DIR) && $(LIBOOP_USE_ACLOCAL)
	cd $(LIBOOP_DIR) && $(LIBOOP_USE_AUTOCONF)
	cd $(LIBOOP_DIR) && $(LIBOOP_USE_AUTOMAKE) -a
	#
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liboop_prepare: $(STATEDIR)/liboop.prepare

LIBOOP_AUTOCONF =
LIBOOP_AUTOCONF += --build=$(GNU_HOST)
LIBOOP_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
LIBOOP_AUTOCONF += --prefix=$(PTXCONF_PREFIX)
LIBOOP_AUTOCONF += --without-tcl

$(STATEDIR)/liboop.prepare: $(STATEDIR)/liboop.extract
	@$(call targetinfo, liboop.prepare)
	cd $(LIBOOP_DIR) &&						\
		PATH=$(PTXCONF_PREFIX)/bin:$$PATH ./configure $(LIBOOP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liboop_compile: $(STATEDIR)/liboop.compile

$(STATEDIR)/liboop.compile: $(STATEDIR)/liboop.prepare 
	@$(call targetinfo, liboop.compile)
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(LIBOOP_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liboop_install: $(STATEDIR)/liboop.install

$(STATEDIR)/liboop.install: $(STATEDIR)/liboop.compile
	@$(call targetinfo, liboop.install)
	# FIXME: this doesn't work when using local bin dir
	make -C $(LIBOOP_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liboop_targetinstall: $(STATEDIR)/liboop.targetinstall

$(STATEDIR)/liboop.targetinstall: $(STATEDIR)/liboop.install
	@$(call targetinfo, liboop.targetinstall)
	# FIXME: the other liboop libraries should optionally be installed 
	# we want to preserve links, so we cannot use install
	cp -d $(PTXCONF_PREFIX)/lib/liboop.so* $(ROOTDIR)/lib/
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/liboop.so*
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liboop_clean: 
	rm -rf $(STATEDIR)/liboop.* $(LIBOOP_DIR)

# vim: syntax=make

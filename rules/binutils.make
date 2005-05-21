# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: this packet installs only libbfd; check what else we would need

ifdef PTXCONF_LIBBFD
PACKAGES += binutils
endif

#
# Paths and names 
#
BINUTILS		= binutils-$(PTXCONF_BINUTILS_VERSION)
BINUTILS_URL		= $(PTXCONF_SETUP_GNUMIRROR)/binutils/$(BINUTILS).tar.gz
BINUTILS_SOURCE		= $(SRCDIR)/$(BINUTILS).tar.gz
BINUTILS_DIR		= $(BUILDDIR)/$(BINUTILS)
BINUTILS_BUILDDIR	= $(BINUTILS_DIR)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

binutils_get: $(STATEDIR)/binutils.get

binutils_get_deps = \
	$(BINUTILS_SOURCE) \
	$(STATEDIR)/binutils-patches.get

$(STATEDIR)/binutils.get: $(binutils_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/binutils-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(BINUTILS))
	touch $@

$(BINUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BINUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

binutils_extract: $(STATEDIR)/binutils.extract

$(STATEDIR)/binutils.extract: $(STATEDIR)/binutils.get
	@$(call targetinfo, $@)
	@$(call clean, $(BINUTILS_DIR))
	@$(call extract, $(BINUTILS_SOURCE))
	@$(call patchin, $(BINUTILS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

binutils_prepare: $(STATEDIR)/binutils.prepare

binutils_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/binutils.extract

BINUTILS_AUTOCONF =  $(CROSS_AUTOCONF)
BINUTILS_AUTOCONF += \
	--target=$(PTXCONF_GNU_TARGET) \
	--enable-targets=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr \
	--disable-nls \
	--enable-shared \
	--enable-commonbfdlib \
	--enable-install-libiberty \
	--disable-multilib

BINUTILS_ENV	= $(CROSS_ENV)
BINUTILS_PATH	= PATH=$(CROSS_PATH)

$(STATEDIR)/binutils.prepare: $(binutils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BINUTILS_BUILDDIR))
	mkdir -p $(BINUTILS_BUILDDIR)
	cd $(BINUTILS_BUILDDIR) && $(BINUTILS_PATH) $(BINUTILS_ENV) \
		$(BINUTILS_DIR)/configure $(BINUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

binutils_compile: $(STATEDIR)/binutils.compile

$(STATEDIR)/binutils.compile: $(STATEDIR)/binutils.prepare 
	@$(call targetinfo, $@)
#
# the libiberty part is compiled for the host system
#
# don't pass target CFLAGS to it, so override them and call the configure script
#
	$(BINUTILS_PATH) make -C $(BINUTILS_BUILDDIR) CFLAGS='' CXXFLAGS='' configure-build-libiberty

#
# the chew tool is needed later during installation, compile it now
# else it will fail cause it gets target CFLAGS
#
	$(BINUTILS_PATH) make -C $(BINUTILS_BUILDDIR)/bfd/doc CFLAGS='' CXXFLAGS='' chew

#
# now do the _real_ compiling :-)
#
	$(BINUTILS_PATH) make -C $(BINUTILS_BUILDDIR)

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

binutils_install: $(STATEDIR)/binutils.install

$(STATEDIR)/binutils.install: $(STATEDIR)/binutils.compile
	@$(call targetinfo, $@)
	cd $(BINUTILS_BUILDDIR)/bfd && \
		$(BINUTILS_PATH) make DESTDIR=$(CROSS_LIB_DIR) prefix='' install 
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

binutils_targetinstall: $(STATEDIR)/binutils.targetinstall

$(STATEDIR)/binutils.targetinstall: $(STATEDIR)/binutils.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,binutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PTXCONF_BINUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: this will probably not work with the wildcard; fix when it breaks :-) 
	@$(call install_copy, 0, 0, 0644, $(BINUTILS_BUILDDIR)/bfd/.libs/libbfd*.so, /usr/lib)

	@$(call install_finish)
	
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

binutils_clean: 
	rm -rf $(STATEDIR)/binutils-* $(BINUTILS_DIR)

# vim: syntax=make

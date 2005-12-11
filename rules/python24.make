# -*-makefile-*-
# $Id: python.make 3172 2005-09-28 15:01:53Z rsc $
#
# Copyright (C) 2003 by David R Bacon
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON24) += python24

#
# Paths and names 
#

PYTHON24_VERSION	= 2.4.2
PYTHON24		= Python-$(PYTHON24_VERSION)
PYTHON24_SUFFIX		= tgz
PYTHON24_URL		= http://www.python.org/ftp/python/$(PYTHON24_VERSION)/$(PYTHON24).$(PYTHON24_SUFFIX)
PYTHON24_SOURCE		= $(SRCDIR)/$(PYTHON24).$(PYTHON24_SUFFIX)
PYTHON24_DIR		= $(BUILDDIR)/$(PYTHON24)
PYTHON24_BUILDDIR	= $(PYTHON24_DIR)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

python24_get: $(STATEDIR)/python24.get

python24_get_deps = \
	$(PYTHON24_SOURCE)

$(STATEDIR)/python24.get: $(python24_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PYTHON24))
	@$(call touch, $@)

$(PYTHON24_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PYTHON24_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

python24_extract: $(STATEDIR)/python24.extract

python24_extract_deps = \
	$(STATEDIR)/python24.get

$(STATEDIR)/python24.extract: $(python24_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON24_DIR))
	@$(call extract, $(PYTHON24_SOURCE))
	@$(call patchin, $(PYTHON24))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

python24_prepare: $(STATEDIR)/python24.prepare

#
# dependencies
#
python24_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/python24.extract

PYTHON24_PATH		=  PATH=$(CROSS_PATH)
PYTHON24_ENV		=  $(CROSS_ENV)

PYTHON24_AUTOCONF 	=  $(CROSS_AUTOCONF)
PYTHON24_AUTOCONF	+= --prefix=/usr
PYTHON24_AUTOCONF 	+= --target=$(PTXCONF_GNU_TARGET)

PYTHON24_MAKEVARS	=  HOSTPYTHON=$(XCHAIN_PYTHON24_BUILDDIR)/python
PYTHON24_MAKEVARS	+= HOSTPGEN=$(XCHAIN_PYTHON24_BUILDDIR)/Parser/pgen
PYTHON24_MAKEVARS	+= CROSS_COMPILE=yes
PYTHON24_MAKEVARS	+= DESTDIR=$(ROOTDIR)

$(STATEDIR)/python24.prepare: $(python24_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON24_BUILDDIR))
	mkdir -p $(PYTHON24_BUILDDIR)
	cd $(PYTHON24_BUILDDIR) && \
		$(PYTHON24_PATH) $(PYTHON24_ENV) \
		$(PYTHON24_DIR)/configure $(PYTHON24_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

python24_compile: $(STATEDIR)/python24.compile

python24_compile_deps = \
	$(STATEDIR)/xchain-python24.compile \
	$(STATEDIR)/python24.prepare

$(STATEDIR)/python24.compile: $(python24_compile_deps)
	@$(call targetinfo, $@)
	cd $(PYTHON24_BUILDDIR) && $(PYTHON24_PATH) make $(PYTHON24_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

python24_install: $(STATEDIR)/python24.install

$(STATEDIR)/python24.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

python24_targetinstall: $(STATEDIR)/python24.targetinstall

$(STATEDIR)/python24.targetinstall: $(STATEDIR)/python24.compile
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,python24)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PYTHON24_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: RSC: ipkgize in a cleaner way

	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		altbininstall DESTDIR=$(ROOTDIR)
	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		altbininstall DESTDIR=$(IMAGEDIR)/ipkg

	umask 022 && \
		$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		libinstall DESTDIR=$(ROOTDIR)
	umask 022 && \
		$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		libinstall DESTDIR=$(IMAGEDIR)/ipkg

	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		libainstall DESTDIR=$(ROOTDIR)
	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		libainstall DESTDIR=$(IMAGEDIR)/ipkg

	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		sharedinstall DESTDIR=$(ROOTDIR)
	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		sharedinstall DESTDIR=$(IMAGEDIR)/ipkg

	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		oldsharedinstall DESTDIR=$(ROOTDIR)
	$(PYTHON24_PATH) make -C $(PYTHON24_BUILDDIR) $(PYTHON24_MAKEVARS) \
		oldsharedinstall DESTDIR=$(IMAGEDIR)/ipkg

	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/python2.4
	$(CROSS_STRIP) -R .note -R .comment $(IMAGEDIR)/ipkg/usr/bin/python2.4

	# remove redundant files
	find $(ROOTDIR)/usr/lib/python2.4 -name "*.py"  | xargs rm -f
	find $(IMAGEDIR)/ipkg/usr/lib/python2.4 -name "*.py"  | xargs rm -f
	find $(ROOTDIR)/usr/lib/python2.4 -name "*.pyo" | xargs rm -f
	find $(IMAGEDIR)/ipkg/usr/lib/python2.4 -name "*.pyo" | xargs rm -f
	rm -fr $(ROOTDIR)/usr/lib/python2.4/config
	rm -fr $(IMAGEDIR)/ipkg/usr/lib/python2.4/config
	rm -fr $(ROOTDIR)/usr/lib/python2.4/test
	rm -fr $(IMAGEDIR)/ipkg/usr/lib/python2.4/test

	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python24_clean: 
	rm -rf $(STATEDIR)/python24.*
	rm -rf $(IMAGEDIR)/python24_*
	rm -fr $(PYTHON24_DIR)
	rm -fr $(PYTHON24_BUILDDIR)

# vim: syntax=make

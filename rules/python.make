# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_PYTHON23) += python

#
# Paths and names 
#

PYTHON_VERSION		= 2.3
PYTHON			= Python-$(PYTHON_VERSION)
PYTHON_SUFFIX		= tgz
PYTHON_URL		= http://www.python.org/ftp/python/$(PYTHON_VERSION)/$(PYTHON).$(PYTHON_SUFFIX)
PYTHON_SOURCE		= $(SRCDIR)/$(PYTHON).$(PYTHON_SUFFIX)
PYTHON_DIR		= $(BUILDDIR)/$(PYTHON)
PYTHON_BUILDDIR		= $(PYTHON_DIR)-build

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

python_get: $(STATEDIR)/python.get

$(STATEDIR)/python.get: $(PYTHON_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PYTHON))
	@$(call touch, $@)

$(PYTHON_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PYTHON_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

python_extract: $(STATEDIR)/python.extract

$(STATEDIR)/python.extract: $(python_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON_DIR))
	@$(call extract, $(PYTHON_SOURCE))
	@$(call patchin, $(PYTHON))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

python_prepare: $(STATEDIR)/python.prepare

PYTHON_PATH	=  PATH=$(CROSS_PATH)
PYTHON_ENV	=  $(CROSS_ENV)

PYTHON_AUTOCONF =  $(CROSS_AUTOCONF_USR)
PYTHON_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)

PYTHON_MAKEVARS	=  HOSTPYTHON=$(XCHAIN_PYTHON_BUILDDIR)/python
PYTHON_MAKEVARS	+= HOSTPGEN=$(XCHAIN_PYTHON_BUILDDIR)/Parser/pgen
PYTHON_MAKEVARS	+= CROSS_COMPILE=yes
PYTHON_MAKEVARS	+= DESTDIR=$(ROOTDIR)

$(STATEDIR)/python.prepare: $(python_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON_BUILDDIR))
	mkdir -p $(PYTHON_BUILDDIR)
	cd $(PYTHON_BUILDDIR) && \
		$(PYTHON_PATH) $(PYTHON_ENV) \
		$(PYTHON_DIR)/configure $(PYTHON_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

python_compile: $(STATEDIR)/python.compile

$(STATEDIR)/python.compile: $(python_compile_deps_default)
	@$(call targetinfo, $@)
	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

python_install: $(STATEDIR)/python.install

$(STATEDIR)/python.install: $(python_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

python_targetinstall: $(STATEDIR)/python.targetinstall

$(STATEDIR)/python.targetinstall: $(python_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,python)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PYTHON_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: RSC: ipkgize in a cleaner way

	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
		altbininstall DESTDIR=$(ROOTDIR)
	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
		altbininstall DESTDIR=$(IMAGEDIR)/ipkg

#	umask 022 && \
#		$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
#		libinstall DESTDIR=$(ROOTDIR)

## 	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
## 		libainstall DESTDIR=$(ROOTDIR)

## 	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
## 		sharedinstall DESTDIR=$(ROOTDIR)

#	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
#		oldsharedinstall DESTDIR=$(ROOTDIR)

	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/python2.3
	$(CROSS_STRIP) -R .note -R .comment $(IMAGEDIR)/ipkg/usr/bin/python2.3

	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python_clean: 
	rm -rf $(STATEDIR)/python.*
	rm -rf $(IMAGEDIR)/python_*
	rm -fr $(PYTHON_DIR)
	rm -fr $(PYTHON_BUILDDIR)

# vim: syntax=make

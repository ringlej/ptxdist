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
ifdef PTXCONF_PYTHON23
PACKAGES += python
endif

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

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

python_get: $(STATEDIR)/python.get

python_get_deps = \
	$(PYTHON_SOURCE)

$(STATEDIR)/python.get: $(python_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PYTHON))
	touch $@

$(PYTHON_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PYTHON_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

python_extract: $(STATEDIR)/python.extract

python_extract_deps = \
	$(STATEDIR)/python.get

$(STATEDIR)/python.extract: $(python_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON_DIR))
	@$(call extract, $(PYTHON_SOURCE))
	@$(call patchin, $(PYTHON))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

python_prepare: $(STATEDIR)/python.prepare

#
# dependencies
#
python_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/python.extract

PYTHON_PATH	=  PATH=$(CROSS_PATH)
PYTHON_ENV	=  $(CROSS_ENV)

PYTHON_AUTOCONF =  $(CROSS_AUTOCONF)
PYTHON_AUTOCONF	+= --prefix=/usr
PYTHON_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)

PYTHON_MAKEVARS	=  HOSTPYTHON=$(XCHAIN_PYTHON_BUILDDIR)/python
PYTHON_MAKEVARS	+= HOSTPGEN=$(XCHAIN_PYTHON_BUILDDIR)/Parser/pgen
PYTHON_MAKEVARS	+= CROSS_COMPILE=yes
PYTHON_MAKEVARS	+= DESTDIR=$(ROOTDIR)

$(STATEDIR)/python.prepare: $(python_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON_BUILDDIR))
	mkdir -p $(PYTHON_BUILDDIR)
	cd $(PYTHON_BUILDDIR) && \
		$(PYTHON_PATH) $(PYTHON_ENV) \
		$(PYTHON_DIR)/configure $(PYTHON_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

python_compile: $(STATEDIR)/python.compile

python_compile_deps = \
	$(STATEDIR)/xchain-python.compile \
	$(STATEDIR)/python.prepare

$(STATEDIR)/python.compile: $(python_compile_deps)
	@$(call targetinfo, $@)
	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

python_install: $(STATEDIR)/python.install

$(STATEDIR)/python.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

python_targetinstall: $(STATEDIR)/python.targetinstall

$(STATEDIR)/python.targetinstall: $(STATEDIR)/python.compile
	@$(call targetinfo, $@)

	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
		altbininstall DESTDIR=$(ROOTDIR)

#	umask 022 && \
#		$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
#		libinstall DESTDIR=$(ROOTDIR)

## 	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
## 		libainstall DESTDIR=$(ROOTDIR)

## 	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
## 		sharedinstall DESTDIR=$(ROOTDIR)

#	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS) \
#		oldsharedinstall DESTDIR=$(ROOTDIR)

	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/python2.3

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python_clean: 
	rm -rf $(STATEDIR)/python.*
	rm -fr $(PYTHON_DIR)
	rm -fr $(PYTHON_BUILDDIR)

# vim: syntax=make

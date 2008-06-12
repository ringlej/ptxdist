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


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PYTHON_SOURCE):
	@$(call targetinfo)
	@$(call get, PYTHON)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/python.extract:
	@$(call targetinfo)
	@$(call clean, $(PYTHON_DIR))
	@$(call extract, PYTHON)
	@$(call patchin, PYTHON)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_PATH	=  PATH=$(CROSS_PATH)
PYTHON_ENV	=  $(CROSS_ENV)

PYTHON_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET)

# FIXME: we probably need to port the host tool side of python
PYTHON_MAKEVARS	:= \
	HOSTPYTHON=python \
	HOSTPGEN=pgen \
	CROSS_COMPILE=yes \
	DESTDIR=$(ROOTDIR)

$(STATEDIR)/python.prepare:
	@$(call targetinfo)
	@$(call clean, $(PYTHON_BUILDDIR))
	mkdir -p $(PYTHON_BUILDDIR)
	cd $(PYTHON_BUILDDIR) && \
		$(PYTHON_PATH) $(PYTHON_ENV) \
		$(PYTHON_DIR)/configure $(PYTHON_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/python.compile:
	@$(call targetinfo)
	$(PYTHON_PATH) make -C $(PYTHON_BUILDDIR) $(PYTHON_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python)
	@$(call install_fixup, python,PACKAGE,python)
	@$(call install_fixup, python,PRIORITY,optional)
	@$(call install_fixup, python,VERSION,$(PYTHON_VERSION))
	@$(call install_fixup, python,SECTION,base)
	@$(call install_fixup, python,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, python,DEPENDS,)
	@$(call install_fixup, python,DESCRIPTION,missing)

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

	@$(call install_finish, python)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python_clean: 
	rm -rf $(STATEDIR)/python.*
	rm -rf $(PKGDIR)/python_*
	rm -rf $(PYTHON_DIR)
	rm -rf $(PYTHON_BUILDDIR)

# vim: syntax=make

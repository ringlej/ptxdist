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

PYTHON24_VERSION	:= 2.4.6
PYTHON24		:= Python-$(PYTHON24_VERSION)
PYTHON24_SUFFIX		:= tgz
PYTHON24_URL		:= http://www.python.org/ftp/python/$(PYTHON24_VERSION)/$(PYTHON24).$(PYTHON24_SUFFIX)
PYTHON24_SOURCE		:= $(SRCDIR)/$(PYTHON24).$(PYTHON24_SUFFIX)
PYTHON24_DIR		:= $(BUILDDIR)/$(PYTHON24)
PYTHON24_PKGDIR		:= $(PKGDIR)/$(PYTHON24)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PYTHON24_SOURCE):
	@$(call targetinfo)
	@$(call get, PYTHON24)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON24_PATH	:= PATH=$(CROSS_PATH)
PYTHON24_ENV	:= $(CROSS_ENV)
PYTHON24_COMPILE_ENV := DESTDIR=$(SYSROOT)

#
# don't use := here
#
PYTHON24_MAKEVARS = \
	HOSTPYTHON=$(PTXCONF_SYSROOT_HOST)/bin/python \
	HOSTPGEN=$(HOST_PYTHON24_DIR)/Parser/pgen \
	CROSS_COMPILE=yes

#
# autoconf
#
PYTHON24_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--enable-shared

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# $(STATEDIR)/python24.compile:
# 	@$(call targetinfo)
# 	( \
# 		export DESTDIR=$(SYSROOT); \
# 		cd $(PYTHON24_DIR) && \
# 			$(PYTHON24_PATH) \
# 			$(PYTHON24_ENV) \
# 			make \
# 			$(PYTHON24_MAKEVARS); \
# 	)
# 	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python24.install:
	@$(call targetinfo)

# first sysroot
	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		altbininstall DESTDIR=$(SYSROOT)

	umask 022 && \
		$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libinstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libainstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		sharedinstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		oldsharedinstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		inclinstall DESTDIR=$(SYSROOT)


# then pkgdir...
	rm -rf $(PYTHON24_PKGDIR)
	mkdir -p $(PYTHON24_PKGDIR)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		altbininstall DESTDIR=$(PYTHON24_PKGDIR)

	umask 022 && \
		$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libinstall DESTDIR=$(PYTHON24_PKGDIR)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libainstall DESTDIR=$(PYTHON24_PKGDIR)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		sharedinstall DESTDIR=$(PYTHON24_PKGDIR)

	$(PYTHON24_PATH) $(MAKE) -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		oldsharedinstall DESTDIR=$(PYTHON24_PKGDIR)

# remove redundant files
	find $(PYTHON24_PKGDIR)/usr/lib/python2.4 -name "*.py"  -print0 | xargs -0 rm -f --
	find $(PYTHON24_PKGDIR)/usr/lib/python2.4 -name "*.pyo" -print0 | xargs -0 rm -f --
	rm -fr $(PYTHON24_PKGDIR)/usr/lib/python2.4/test

ifndef PTXCONF_PYTHON24_CONFIG
	rm -fr $(PYTHON24_PKGDIR)/usr/lib/python2.4/config
endif

ifndef PTXCONF_PYTHON24_LIBTK
	rm -fr $(PYTHON24_PKGDIR)/usr/lib/python2.4/lib-tk
endif

ifndef PTXCONF_PYTHON24_IDLELIB
	rm -fr $(PYTHON24_PKGDIR)/usr/lib/python2.4/idlelib
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python24.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python24)
	@$(call install_fixup, python24,PACKAGE,python24)
	@$(call install_fixup, python24,PRIORITY,optional)
	@$(call install_fixup, python24,VERSION,$(PYTHON24_VERSION))
	@$(call install_fixup, python24,SECTION,base)
	@$(call install_fixup, python24,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, python24,DEPENDS,)
	@$(call install_fixup, python24,DESCRIPTION,missing)

	cd $(PYTHON24_PKGDIR) && find -type f | \
		while read file; do \
		$(call install_copy, python24, 0, 0, $$(stat -c "0%a" $$file), $(PYTHON24_PKGDIR)/$$file, $$file); \
	done

ifdef PTXCONF_PYTHON24_SYMLINK
	@$(call install_link, python24, python2.4, /usr/bin/python)
endif

	@$(call install_finish, python24)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python24_clean:
	rm -rf $(STATEDIR)/python24.*
	rm -rf $(PKGDIR)/python24_*
	rm -fr $(PYTHON24_DIR)

# vim: syntax=make

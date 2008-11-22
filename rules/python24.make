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


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

python24_get: $(STATEDIR)/python24.get

$(STATEDIR)/python24.get: $(python24_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PYTHON24_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PYTHON24)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

python24_extract: $(STATEDIR)/python24.extract

$(STATEDIR)/python24.extract: $(python24_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PYTHON24_DIR))
	@$(call extract, PYTHON24)
	@$(call patchin, PYTHON24)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

python24_prepare: $(STATEDIR)/python24.prepare

PYTHON24_PATH		:= PATH=$(CROSS_PATH)
PYTHON24_ENV		:= $(CROSS_ENV)

PYTHON24_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--enable-shared

PYTHON24_MAKEVARS	:= \
	HOSTPYTHON=$(PTXCONF_SYSROOT_HOST)/bin/python \
	HOSTPGEN=$(HOST_PYTHON24_DIR)/Parser/pgen \
	CROSS_COMPILE=yes

$(STATEDIR)/python24.prepare: $(python24_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(PYTHON24_DIR) && \
		$(PYTHON24_PATH) $(PYTHON24_ENV) \
		$(PYTHON24_DIR)/configure $(PYTHON24_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

python24_compile: $(STATEDIR)/python24.compile

$(STATEDIR)/python24.compile: $(python24_compile_deps_default)
	@$(call targetinfo, $@)
	( \
		export DESTDIR=$(SYSROOT); \
		cd $(PYTHON24_DIR) && \
			$(PYTHON24_PATH) \
			$(PYTHON24_ENV) \
			make \
			$(PYTHON24_MAKEVARS); \
	)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

python24_install: $(STATEDIR)/python24.install

$(STATEDIR)/python24.install: $(python24_install_deps_default)
	@$(call targetinfo, $@)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		altbininstall DESTDIR=$(SYSROOT)

	umask 022 && \
		$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libinstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libainstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		sharedinstall DESTDIR=$(SYSROOT)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		oldsharedinstall DESTDIR=$(SYSROOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON24_INST_TMP := $(PYTHON24_DIR)/install_temp

python24_targetinstall: $(STATEDIR)/python24.targetinstall

$(STATEDIR)/python24.targetinstall: $(python24_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, python24)
	@$(call install_fixup, python24,PACKAGE,python24)
	@$(call install_fixup, python24,PRIORITY,optional)
	@$(call install_fixup, python24,VERSION,$(PYTHON24_VERSION))
	@$(call install_fixup, python24,SECTION,base)
	@$(call install_fixup, python24,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, python24,DEPENDS,)
	@$(call install_fixup, python24,DESCRIPTION,missing)

	rm -rf $(PYTHON24_INST_TMP)
	mkdir -p $(PYTHON24_INST_TMP)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		altbininstall DESTDIR=$(PYTHON24_INST_TMP)

	umask 022 && \
		$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libinstall DESTDIR=$(PYTHON24_INST_TMP)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		libainstall DESTDIR=$(PYTHON24_INST_TMP)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		sharedinstall DESTDIR=$(PYTHON24_INST_TMP)

	$(PYTHON24_PATH) make -C $(PYTHON24_DIR) $(PYTHON24_MAKEVARS) \
		oldsharedinstall DESTDIR=$(PYTHON24_INST_TMP)

	# remove redundant files
	find $(PYTHON24_INST_TMP)/usr/lib/python2.4 -name "*.py"  | xargs rm -f
	find $(PYTHON24_INST_TMP)/usr/lib/python2.4 -name "*.pyo" | xargs rm -f
	rm -fr $(PYTHON24_INST_TMP)/usr/lib/python2.4/test
ifndef PTXCONF_PYTHON24_CONFIG
	rm -fr $(PYTHON24_INST_TMP)/usr/lib/python2.4/config
endif
ifndef PTXCONF_PYTHON24_LIBTK
	rm -fr $(PYTHON24_INST_TMP)/usr/lib/python2.4/lib-tk
endif
ifndef PTXCONF_PYTHON24_IDLELIB
	rm -fr $(PYTHON24_INST_TMP)/usr/lib/python2.4/idlelib
endif

	files=$$(cd $(PYTHON24_INST_TMP) && find -type f | sed "s/^\.//"); \
	for i in $$files; do \
		access=$$(stat -c "%a" $(PYTHON24_INST_TMP)$$i); \
		$(call install_copy, python24, 0, 0, $$access, $(PYTHON24_INST_TMP)$$i, $$i); \
	done
ifdef PTXCONF_PYTHON24_SYMLINK
	@$(call install_link, python24, python2.4, /usr/bin/python)
endif

	@$(call install_finish, python24)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

python24_clean:
	rm -rf $(STATEDIR)/python24.*
	rm -rf $(PKGDIR)/python24_*
	rm -fr $(PYTHON24_DIR)

# vim: syntax=make

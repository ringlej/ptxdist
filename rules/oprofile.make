# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPROFILE) += oprofile

#
# Paths and names
#
OPROFILE_VERSION	= 0.9.3
OPROFILE		= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		= tar.gz
OPROFILE_URL		= $(PTXCONF_SETUP_SFMIRROR)/oprofile/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_SOURCE		= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		= $(BUILDDIR)/$(OPROFILE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

oprofile_get: $(STATEDIR)/oprofile.get

$(STATEDIR)/oprofile.get: $(oprofile_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPROFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OPROFILE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

oprofile_extract: $(STATEDIR)/oprofile.extract

$(STATEDIR)/oprofile.extract: $(oprofile_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR))
	@$(call extract, OPROFILE)
	@$(call patchin, OPROFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

oprofile_prepare: $(STATEDIR)/oprofile.prepare

OPROFILE_PATH	=  PATH=$(CROSS_PATH)
OPROFILE_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OPROFILE_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
OPROFILE_AUTOCONF	+= --with-kernel-support
#
# note: we must use here the kernel's makevars (ARCH=fo CROSS_COMPILE=bar)
#       (see kernel.make) because oprofile includes the kernel's makefile
#       in it's modules subdir, and there it doesn't care about the CC
#       we gave him at ./configure-time....
#
OPROFILE_MAKEVARS	=  $(KERNEL_MAKEVARS)

$(STATEDIR)/oprofile.prepare: $(oprofile_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPROFILE_DIR)/config.cache)
	cd $(OPROFILE_DIR) && \
		$(OPROFILE_PATH) $(OPROFILE_ENV) \
		./configure $(OPROFILE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

oprofile_compile: $(STATEDIR)/oprofile.compile

$(STATEDIR)/oprofile.compile: $(oprofile_compile_deps_default)
	@$(call targetinfo, $@)
	$(OPROFILE_PATH) make -C $(OPROFILE_DIR) $(OPROFILE_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

oprofile_install: $(STATEDIR)/oprofile.install

$(STATEDIR)/oprofile.install: $(oprofile_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, OPROFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

oprofile_targetinstall: $(STATEDIR)/oprofile.targetinstall

$(STATEDIR)/oprofile.targetinstall: $(oprofile_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, oprofile)
	@$(call install_fixup, oprofile,PACKAGE,oprofile)
	@$(call install_fixup, oprofile,PRIORITY,optional)
	@$(call install_fixup, oprofile,VERSION,$(MAD_VERSION))
	@$(call install_fixup, oprofile,SECTION,base)
	@$(call install_fixup, oprofile,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, oprofile,DEPENDS,)
	@$(call install_fixup, oprofile,DESCRIPTION,missing)

	@$(call install_copy, oprofile, 0, 0, 0755, $(OPROFILE_DIR)/utils/opcontrol, \
		/usr/bin/opcontrol, 0)
	@$(call install_copy, oprofile, 0, 0, 0755, $(OPROFILE_DIR)/pp/opreport, \
		/usr/bin/opreport)
	@$(call install_copy, oprofile, 0, 0, 0755, $(OPROFILE_DIR)/daemon/oprofiled, \
		/usr/bin/oprofiled)
	@$(call install_copy, oprofile, 0, 0, 0755, $(OPROFILE_DIR)/utils/ophelp, \
		/usr/bin/ophelp)

	#
	# Currently we install the events and unit_mask files for all architectures.
	# This wastes some space.
	#
	@for i in $$(find $(OPROFILE_DIR)/events/ -name "unit_masks" -o -name "events"); do \
		$(call install_copy, oprofile, 0, 0, 0755, $$i, \
			/usr/share/oprofile/$$(echo $$i | sed "s^$(OPROFILE_DIR)/events^^"), 0); \
	done

	@$(call install_finish, oprofile)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

oprofile_clean:
	rm -rf $(STATEDIR)/oprofile.*
	rm -rf $(OPROFILE_DIR)

# vim: syntax=make

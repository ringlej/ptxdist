# -*-makefile-*-
# $Id: template 3502 2005-12-11 12:46:17Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETPBM) += libnetpbm

#
# Paths and names
#
LIBNETPBM_VERSION	= 10.31
LIBNETPBM		= netpbm-$(LIBNETPBM_VERSION)
LIBNETPBM_SUFFIX	= tgz
LIBNETPBM_URL		= http://puzzle.dl.sourceforge.net/sourceforge/netpbm/$(LIBNETPBM).$(LIBNETPBM_SUFFIX)
LIBNETPBM_SOURCE	= $(SRCDIR)/$(LIBNETPBM).$(LIBNETPBM_SUFFIX)
LIBNETPBM_DIR		= $(BUILDDIR)/$(LIBNETPBM)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libnetpbm_get: $(STATEDIR)/libnetpbm.get

$(STATEDIR)/libnetpbm.get: $(LIBNETPBM_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBNETPBM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBNETPBM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libnetpbm_extract: $(STATEDIR)/libnetpbm.extract

$(STATEDIR)/libnetpbm.extract: $(libnetpbm_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBNETPBM_DIR))
	@$(call extract, $(LIBNETPBM_SOURCE))
	@$(call patchin, $(LIBNETPBM))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libnetpbm_prepare: $(STATEDIR)/libnetpbm.prepare

LIBNETPBM_PATH	=  PATH=$(CROSS_PATH)
LIBNETPBM_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/libnetpbm.prepare: $(libnetpbm_prepare_deps_default)
	@$(call targetinfo, $@)
	cp $(LIBNETPBM_DIR)/Makefile.config.in $(LIBNETPBM_DIR)/Makefile.config
ifdef PTXCONF_LIBNETPBM_BUILD_FIASCO
	sed -ie "s,^BUILD_FIASCO.*,BUILD_FIASCO=Y,g" $(LIBNETPBM_DIR)/Makefile.config
else
	sed -ie "s,^BUILD_FIASCO.*,BUILD_FIASCO=N,g" $(LIBNETPBM_DIR)/Makefile.config
endif
	sed -ie "s,^CC =.*,CC=$(CROSS_CC),g" $(LIBNETPBM_DIR)/Makefile.config
	sed -ie "s,^LINKER_CAN_DO_EXPLICIT_LIBRARY.*,LINKER_CAN_DO_EXPLICIT_LIBRARY=Y,g" $(LIBNETPBM_DIR)/Makefile.config
	sed -ie "s,^INTTYPES_H.*,INTTYPES_H = <stdint.h>,g" $(LIBNETPBM_DIR)/Makefile.config
	sed -ie "s,^CC_FOR_BUILD.*,CC_FOR_BUILD=$(HOSTCC),g" $(LIBNETPBM_DIR)/Makefile.config
	sed -ie "s,^LD_FOR_BUILD.*,LD_FOR_BUILD=$(HOSTCC),g" $(LIBNETPBM_DIR)/Makefile.config
	sed -ie "s,^CFLAGS_FOR_BUILD.*,CFLAGS_FOR_BUILD=,g" $(LIBNETPBM_DIR)/Makefile.config
	echo "CFLAGS=$(CROSS_CFLAGS) $(CROSS_CPPFLAGS)" >> $(LIBNETPBM_DIR)/Makefile.config
	
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libnetpbm_compile: $(STATEDIR)/libnetpbm.compile

$(STATEDIR)/libnetpbm.compile: $(libnetpbm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBNETPBM_DIR) && $(LIBNETPBM_ENV) $(LIBNETPBM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libnetpbm_install: $(STATEDIR)/libnetpbm.install

$(STATEDIR)/libnetpbm.install: $(STATEDIR)/libnetpbm.compile
	@$(call targetinfo, $@)
	cp $(LIBNETPBM_DIR)/lib/libnetpbm.so.10.31 $(SYSROOT)/usr/lib/libnetpbm.so.10.31
	ln -sf libnetpbm.so.10.31 $(SYSROOT)/usr/lib/libnetpbm.so.10
	ln -sf libnetpbm.so.10.31 $(SYSROOT)/usr/lib/libnetpbm.so
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libnetpbm_targetinstall: $(STATEDIR)/libnetpbm.targetinstall

$(STATEDIR)/libnetpbm.targetinstall: $(libnetpbm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libnetpbm)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBNETPBM_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(LIBNETPBM_DIR)/lib/libnetpbm.so.10.31, \
		/usr/lib/libnetpbm.so.10.31)

	@$(call install_link, libnetpbm.so.10.31, /usr/lib/libnetpbm.so.10)
	@$(call install_link, libnetpbm.so.10.31, /usr/lib/libnetpbm.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libnetpbm_clean:
	rm -rf $(STATEDIR)/libnetpbm.*
	rm -rf $(IMAGEDIR)/libnetpbm_*
	rm -rf $(LIBNETPBM_DIR)

# vim: syntax=make

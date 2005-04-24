# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_UTLNX
PACKAGES += util-linux
endif

#
# Paths and names
#
UTIL-LINUX_VERSION	= 2.12
UTIL-LINUX		= util-linux-$(UTIL-LINUX_VERSION)
UTIL-LINUX_SUFFIX	= tar.gz
UTIL-LINUX_URL		= http://ftp.cwi.nl/aeb/util-linux/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_SOURCE	= $(SRCDIR)/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_DIR		= $(BUILDDIR)/$(UTIL-LINUX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

util-linux_get: $(STATEDIR)/util-linux.get

util-linux_get_deps	=  $(UTIL-LINUX_SOURCE)

$(STATEDIR)/util-linux.get: $(util-linux_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(UTIL-LINUX))
	touch $@

$(UTIL-LINUX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(UTIL-LINUX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

util-linux_extract: $(STATEDIR)/util-linux.extract

util-linux_extract_deps	=  $(STATEDIR)/util-linux.get

$(STATEDIR)/util-linux.extract: $(util-linux_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL-LINUX_DIR))
	@$(call extract, $(UTIL-LINUX_SOURCE))
	@$(call patchin, $(UTIL-LINUX))

	perl -i -p -e 's/^CPU=.*$$/CPU=$(PTXCONF_ARCH)/g' $(UTIL-LINUX_DIR)/MCONFIG
	touch $@
	
# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

util-linux_prepare: $(STATEDIR)/util-linux.prepare

#
# dependencies
#
util-linux_prepare_deps =  \
	$(STATEDIR)/util-linux.extract \
	$(STATEDIR)/virtual-xchain.install

UTIL-LINUX_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
UTIL-LINUX_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/util-linux.prepare: $(util-linux_prepare_deps)
	@$(call targetinfo, $@)
	cd $(UTIL-LINUX_DIR) && \
		$(UTIL-LINUX_PATH) $(UTIL-LINUX_ENV) \
		./configure
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

util-linux_compile: $(STATEDIR)/util-linux.compile

util-linux_compile_deps =  $(STATEDIR)/util-linux.prepare

$(STATEDIR)/util-linux.compile: $(util-linux_compile_deps)
	@$(call targetinfo, $@)

	cd $(UTIL-LINUX_DIR)/lib && $(UTIL-LINUX_PATH) make all
ifdef PTXCONF_UTLNX_MKSWAP
	cd $(UTIL-LINUX_DIR)/disk-utils && $(UTIL-LINUX_PATH) make mkswap
endif
ifdef PTXCONF_UTLNX_SWAPON
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make swapon
endif
ifdef PTXCONF_UTLNX_MOUNT
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make mount
endif
ifdef PTXCONF_UTLNX_IPCS
	cd $(UTIL-LINUX_DIR)/sys-utils && $(UTIL-LINUX_PATH) make ipcs
endif
ifdef PTXCONF_UTLNX_READPROFILE
	cd $(UTIL-LINUX_DIR)/sys-utils && $(UTIL-LINUX_PATH) make readprofile
endif
ifdef PTXCONF_UTLNX_FDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make fdisk
endif
ifdef PTXCONF_UTLNX_SFDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make sfdisk
endif
ifdef PTXCONF_UTLNX_CFDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make cfdisk
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

util-linux_install: $(STATEDIR)/util-linux.install

$(STATEDIR)/util-linux.install: $(STATEDIR)/util-linux.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

util-linux_targetinstall: $(STATEDIR)/util-linux.targetinstall

util-linux_targetinstall_deps	=  $(STATEDIR)/util-linux.compile
util-linux_targetinstall_deps	+= $(STATEDIR)/hosttool-ipkg-utils.install
util-linux_targetinstall_deps	+= $(STATEDIR)/hosttool-fakeroot.install

$(STATEDIR)/util-linux.targetinstall: $(util-linux_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,util-linux)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UTIL-LINUX_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_UTLNX_MKSWAP
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/disk-utils/mkswap, /sbin/mkswap)
endif
ifdef PTXCONF_UTLNX_SWAPON
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/swapon, /sbin/swapon)
endif
ifdef PTXCONF_UTLNX_IPCS
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/sys-utils/ipcs, /usr/bin/ipcs)
endif
ifdef PTXCONF_UTLNX_READPROFILE
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/sys-utils/readprofile, /usr/sbin/readprofile)
endif
ifdef PTXCONF_UTLNX_FDISK
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/fdisk, /usr/sbin/fdisk)
endif
ifdef PTXCONF_UTLNX_SFDISK
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/sfdisk, /usr/sbin/sfdisk)
endif
ifdef PTXCONF_UTLNX_CFDISK
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/cfdisk, /usr/sbin/cfdisk)
endif
	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

util-linux_clean:
	rm -rf $(STATEDIR)/util-linux.*
	rm -rf $(IMAGEDIR)/util-linux_*
	rm -rf $(UTIL-LINUX_DIR)

# vim: syntax=make

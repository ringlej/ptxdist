# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation, by Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_SYS-EPOLL-LIB
PACKAGES += sys-epoll-lib
endif

#
# Paths and names
#
SYS-EPOLL-LIB_VERSION	= 0.10
SYS-EPOLL-LIB		= epoll-lib-$(SYS-EPOLL-LIB_VERSION)
SYS-EPOLL-LIB_SUFFIX	= tar.gz
SYS-EPOLL-LIB_URL	= http://www.xmailserver.org/linux-patches/$(SYS-EPOLL-LIB).$(SYS-EPOLL-LIB_SUFFIX)
SYS-EPOLL-LIB_SOURCE	= $(SRCDIR)/$(SYS-EPOLL-LIB).$(SYS-EPOLL-LIB_SUFFIX)
SYS-EPOLL-LIB_DIR	= $(BUILDDIR)/$(SYS-EPOLL-LIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sys-epoll-lib_get: $(STATEDIR)/sys-epoll-lib.get

sys-epoll-lib_get_deps = $(SYS-EPOLL-LIB_SOURCE)

$(STATEDIR)/sys-epoll-lib.get: $(sys-epoll-lib_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(SYS-EPOLL-LIB))
	touch $@

$(SYS-EPOLL-LIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SYS-EPOLL-LIB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sys-epoll-lib_extract: $(STATEDIR)/sys-epoll-lib.extract

sys-epoll-lib_extract_deps =  $(STATEDIR)/sys-epoll-lib.get

$(STATEDIR)/sys-epoll-lib.extract: $(sys-epoll-lib_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYS-EPOLL-LIB_DIR))
	@$(call extract, $(SYS-EPOLL-LIB_SOURCE))
	@$(call patchin, $(SYS-EPOLL-LIB))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sys-epoll-lib_prepare: $(STATEDIR)/sys-epoll-lib.prepare

#
# dependencies
#
sys-epoll-lib_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.prepare \
	$(STATEDIR)/sys-epoll-lib.extract

SYS-EPOLL-LIB_PATH	=  PATH=$(CROSS_PATH)
SYS-EPOLL-LIB_MAKEVARS = \
	$(CROSS_ENV) \
	KERNELDIR=$(KERNEL_DIR) \
	PREFIX=$(CROSS_LIB_DIR) \
	XCFLAGS='$(strip $(subst ",,$(TARGET_CFLAGS)))'

$(STATEDIR)/sys-epoll-lib.prepare: $(sys-epoll-lib_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sys-epoll-lib_compile: $(STATEDIR)/sys-epoll-lib.compile

sys-epoll-lib_compile_deps = $(STATEDIR)/sys-epoll-lib.prepare

$(STATEDIR)/sys-epoll-lib.compile: $(sys-epoll-lib_compile_deps)
	@$(call targetinfo, $@)
	$(SYS-EPOLL-LIB_PATH) make $(SYS-EPOLL-LIB_MAKEVARS) -C $(SYS-EPOLL-LIB_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sys-epoll-lib_install: $(STATEDIR)/sys-epoll-lib.install

$(STATEDIR)/sys-epoll-lib.install: $(STATEDIR)/sys-epoll-lib.compile
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/man/man2
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/man/man4
	$(SYS-EPOLL-LIB_PATH) make $(SYS-EPOLL-LIB_MAKEVARS) -C $(SYS-EPOLL-LIB_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sys-epoll-lib_targetinstall: $(STATEDIR)/sys-epoll-lib.targetinstall

sys-epoll-lib_targetinstall_deps = $(STATEDIR)/sys-epoll-lib.install

$(STATEDIR)/sys-epoll-lib.targetinstall: $(sys-epoll-lib_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sys-epoll-lib_clean:
	rm -rf $(STATEDIR)/sys-epoll-lib.*
	rm -rf $(SYS-EPOLL-LIB_DIR)

# vim: syntax=make

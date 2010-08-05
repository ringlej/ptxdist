# -*-makefile-*-
#
# Copyright (C) 2010 by Stephan Linz
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_X_LOAD) += x-load

#
# Paths and names
#
X_LOAD_VERSION	:= $(call remove_quotes,$(PTXCONF_X_LOAD_VERSION))
X_LOAD		:= x-load-$(X_LOAD_VERSION)
X_LOAD_SUFFIX	:= tar.bz2
X_LOAD_URL	:= http://www.ptxdist.org/software/ptxdist/temporary-src/$(X_LOAD).$(X_LOAD_SUFFIX)
X_LOAD_SOURCE	:= $(SRCDIR)/$(X_LOAD).$(X_LOAD_SUFFIX)
X_LOAD_DIR	:= $(BUILDDIR)/$(X_LOAD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

X_LOAD_MAKE_OPT	:= CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE) HOSTCC=$(HOSTCC)
X_LOAD_MAKE_PAR	:= NO

$(STATEDIR)/x-load.prepare:
	@$(call targetinfo)
	@$(call compile, X_LOAD, $(PTXCONF_X_LOAD_CONFIG))
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

X_LOAD_BUILD_TARGETS	:= all

ifdef PTXCONF_X_LOAD_MAKE_IFT
X_LOAD_BUILD_TARGETS	+= ift
endif

$(STATEDIR)/x-load.compile:
	@$(call targetinfo)
ifneq ($(strip $(X_LOAD_BUILD_TARGETS)), )
	@$(call compile, X_LOAD, $(X_LOAD_BUILD_TARGETS))
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x-load.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x-load.targetinstall:
	@$(call targetinfo)
	@install -D -m644 $(X_LOAD_DIR)/x-load.bin $(IMAGEDIR)/x-load.bin
ifdef PTXCONF_X_LOAD_MAKE_IFT
	@install -D -m644 $(X_LOAD_DIR)/x-load.bin.ift $(IMAGEDIR)/x-load.bin.ift
	@install -D -m644 $(X_LOAD_DIR)/x-load.bin.ift $(IMAGEDIR)/MLO
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/x-load.clean:
	@$(call targetinfo)
	@$(call clean_pkg, X_LOAD)
	@rm -f $(IMAGEDIR)/x-load.bin $(IMAGEDIR)/x-load.bin.ift $(IMAGEDIR)/MLO

# vim: syntax=make

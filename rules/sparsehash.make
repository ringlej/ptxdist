# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>


PACKAGES-$(PTXCONF_SPARSEHASH) += sparsehash

#
# Paths and names
#
SPARSEHASH_NAME		:= sparsehash
SPARSEHASH_VERSION	:= 1.11
SPARSEHASH_MD5		:= 53a9bb4b3fb11fc6fca9bf938c1b1ce9 622642f71c9a566b33d5407125198378
SPARSEHASH		:= $(SPARSEHASH_NAME)-$(SPARSEHASH_VERSION)
SPARSEHASH_SUFFIX	:= tar.gz
SPARSEHASH_URL		:= https://github.com/sparsehash/sparsehash/archive/$(SPARSEHASH).$(SPARSEHASH_SUFFIX)
SPARSEHASH_SOURCE	:= $(SRCDIR)/$(SPARSEHASH).$(SPARSEHASH_SUFFIX)
SPARSEHASH_DIR		:= $(BUILDDIR)/$(SPARSEHASH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPARSEHASH_PATH	:= PATH=$(CROSS_PATH)
SPARSEHASH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SPARSEHASH_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sparsehash.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
